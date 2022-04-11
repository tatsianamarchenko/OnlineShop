//
//  DataBaseFile.swift
//  smes
//
//  Created by Tatsiana Marchanka on 27.10.21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import CoreMedia

final class FirebaseManager {
	static let shered = FirebaseManager()
	let db = Firestore.firestore()
	/// sent new users to database
	public func insertUser(with user: AppUser,  completion: @escaping (Error) -> Void) {
		Auth.auth().createUser(withEmail: user.email, password: user.passward) { [weak self] authResult, error in
			if  error != nil {
				completion(error!)
			}
			else {
				let db = Firestore.firestore()
				db.collection("users").document(user.email).setData(["fullName": user.fullName,
																	 "phone": user.phone,
																	 "adress": user.adress,
																	 "zip": user.zip,
																	 "email": user.email,
																	 "passward": user.passward,
																	 "cart": [],
																	 "favorite": []]) { error in
					if error != nil {
						completion(error!)
					}
				}

				UserDefaults.standard.set(user.email, forKey: "user")
			}
		}
	}

	public func enterUser(with email: String, passward: String, completion: @escaping((Result<AuthDataResult, Error>) -> Void)) {
		Auth.auth().signIn(withEmail: email, password: passward) { [weak self] authResult, error in
			if  error != nil {
				completion(.failure(error!))
			}
			else {
				UserDefaults.standard.set(email, forKey: "user")
				completion(.success(authResult!))
			}
		}
	}

	public func signOut (completion: @escaping((Result<Void, Error>) -> Void)) {
		do {
			let a = try Auth.auth().signOut()
			completion(.success(a))
		} catch let error {
			completion(.failure(error))
		}
	}

	public func isPasswardValid(_ passward: String) -> Bool {
		let passwardPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
		return passwardPredicate.evaluate(with: passward)
	}

	struct AppUser {
		let fullName: String
		let phone: String
		let adress: String
		let zip: String
		let email: String
		let passward: String
	}

	public func fetchData(document: String, complition: @escaping (Category)-> Void) {
		db.collection(document).getDocuments { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else {
				print("No documents")
				return
			}
			documents.map { queryDocumentSnapshot in
				let	data = queryDocumentSnapshot.data()
				var image: Image?
				let name = data["name"] as? String ?? ""
				let path = data["image"] as? String ?? ""

				let storage = Storage.storage().reference()
				let fileRef = storage.child(path)
				fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
					if error == nil {
						image = Image(withImage: data!)
						let f = Category(image: image, name: name)
						complition(f)
					}
				}
			}
		}
	}

	public func fetchImage(collection: String, imageView: UIImageView) {
		db.collection(collection).getDocuments { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else {
				print("No documents")
				return
			}
			documents.map { queryDocumentSnapshot in
				let	data = queryDocumentSnapshot.data()
				let path = data["image"] as? String ?? ""
				let storage = Storage.storage().reference()
				let fileRef = storage.child(path)
				fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
					if error == nil {
						imageView.image = UIImage(data: data!)!
					}
				}
			}
		}
	}


	public func fetchMain(document: String, complition: @escaping (Flower)-> Void) {
		db.collection(document).getDocuments { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else {
				print("No documents")
				return
			}
			documents.map { queryDocumentSnapshot in
				let	data = queryDocumentSnapshot.data()
				var image: Image?
				let type = data["type"] as? String ?? ""
				let description = data["description"] as? String ?? ""
				let title = data["title"] as? String ?? ""
				let price = data["price"] as? String ?? ""
				let path = data["image"] as? String ?? ""
				let sun = data["sun"] as? String ?? ""
				let water = data["water"] as? String ?? ""
				let temperature = data["temperature"] as? String ?? ""
				let id = queryDocumentSnapshot.documentID

				let storage = Storage.storage().reference()
				let fileRef = storage.child(path)
				fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
					if error == nil {
						image = Image(withImage: data!)
						let f = Flower(description: description, image: image, price: price, title: title, type: type, sun: sun, water: water, temperature: temperature, id: id)
						complition(f)
					}
				}
			}
		}
	}

	public func fetchCartItem(collection: String, field: String, complition: @escaping (Flower)-> Void) {
		guard let user = Auth.auth().currentUser?.email else {return}
		let db = Firestore.firestore()
		var collection = db.collection(collection).document(user)

		collection.getDocument { documentSnapshot, error in
			var cart = documentSnapshot?[field] as? [String]
			guard let cart = cart else {return}
			for i in 0..<cart.count {
				let collection = db.collection("Flowers").document(cart[i])
				collection.getDocument { documentSnapshot, error in
					var image: Image?
					let type = documentSnapshot?["type"] as? String ?? ""
					let description = documentSnapshot?["description"] as? String ?? ""
					let title = documentSnapshot?["title"] as? String ?? ""
					let price = documentSnapshot?["price"] as? String ?? ""
					let path = documentSnapshot?["image"] as? String ?? ""
					let sun = documentSnapshot?["sun"] as? String ?? ""
					let water = documentSnapshot?["water"] as? String ?? ""
					let temperature = documentSnapshot?["temperature"] as? String ?? ""
					let id = documentSnapshot?.documentID ?? ""

					let storage = Storage.storage().reference()
					let fileRef = storage.child(path)
					fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
						if error == nil {
							image = Image(withImage: data!)
							let f = Flower(description: description, image: image, price: price, title: title, type: type, sun: sun, water: water, temperature: temperature, id: id)
							complition(f)
						}
					}
				}
			}
		}
	}

	public func addToCart(flower: Flower , complition: @escaping (Result<Void, Error>) -> Void) {
		guard let user = Auth.auth().currentUser?.email else {return}
		let collection = db.collection("users").document(user)
		collection.getDocument { documentSnapshot, error in
			var cart = documentSnapshot?["cart"] as? [String]
			cart?.append(flower.id)
			collection.updateData(["cart": cart]) { error in
				if error != nil {
					complition(.failure(error!))
				} else {
					complition(.success(()))
				}

			}
		}
	}

	public func addToFavorite(flower: Flower , complition: @escaping (Result<Void, Error>) -> Void) {
		guard let user = Auth.auth().currentUser?.email else {return}
		var collection = db.collection("users").document(user)
		collection.getDocument { documentSnapshot, error in
			var favorite = documentSnapshot?["favorite"] as? [String]
			favorite?.append(flower.id)
			collection.updateData(["favorite": favorite]) { error in
				if error != nil {
					complition(.failure(error!))
				} else {
					complition(.success(()))
				}

			}
		}
	}

//	public func deliteFromFavorite(flower: Flower? , complition: @escaping () -> Void) {
//		guard let user = Auth.auth().currentUser?.email else {return}
//		db.collection("users").document(user).updateData(["favorite": FieldValue.delete()])
//	}

	public func deliteFromFavorite(flower: Flower, complition: @escaping (Flower) -> Void) {
		guard let user = Auth.auth().currentUser?.email else {return}
		let a = db.collection("users").document(user)
		complition(flower)
		a.updateData([
			"favorite" : FieldValue.arrayRemove([flower.id])
		]) { error in
			if let error = error {
				print("error: \(error)")
			} else {
				print("successfully deleted")
			}
		}
	}

	public func deliteFromCart(flower: Flower, complition: @escaping (Flower) -> Void) {
		guard let user = Auth.auth().currentUser?.email else {return}
		let a = db.collection("users").document(user)
		complition(flower)
		a.updateData([
			"cart" : FieldValue.arrayRemove([flower.id])
		]) { error in
			if let error = error {
				print("error: \(error)")
			} else {
				print("successfully deleted")
			}
		}
	}

}


class IndexedButton: UIButton {
  var buttonIndexPath: IndexPath

  init(buttonIndexPath: IndexPath) {
	self.buttonIndexPath = buttonIndexPath
	super.init(frame: .zero)
  }
  required init?(coder aDecoder: NSCoder) {
	fatalError("init(coder:) has not been implemented")
  }
}
