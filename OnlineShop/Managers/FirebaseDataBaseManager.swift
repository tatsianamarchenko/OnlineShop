//
//  DataBaseFile.swift
//  smes
//
//  Created by Tatsiana Marchanka on 27.10.21.
//

import Foundation
import Firebase

final class FirebaseDataBaseManager {

	static let shered = FirebaseDataBaseManager()
	private let db = Firestore.firestore()
	private let userEmail = Auth.auth().currentUser?.email
	private let usersCollectionFirebase = "users"

	public func addUserToDatabase(with user: FirebaseAuthManager.AppUser) {
		db.collection(self.usersCollectionFirebase).document(user.email).setData(["fullName": user.fullName,
																				  "phone": user.phone,
																				  "adress": user.adress,
																				  "zip": user.zip,
																				  "email": user.email,
																				  "passward": user.passward,
																				  "cart": [],
																				  "favorite": []])
	}

	public func getUserFromDatabase(with userEmail: String, field: String, complition: @escaping (GeneralUser)-> Void) {
		db.collection(self.usersCollectionFirebase).document(userEmail).getDocument { documentSnapshot, error in
			let fullName = documentSnapshot?["fullName"] as? String ?? ""
			let phone = documentSnapshot?["phone"] as? String ?? ""
			let adress = documentSnapshot?["adress"] as? String ?? ""
			let zip = documentSnapshot?["zip"] as? String ?? ""
			let email = documentSnapshot?["email"] as? String ?? ""
			let generalUser = GeneralUser(fullNam: fullName, phone: phone, adress: adress, zip: zip, email: email)
			complition(generalUser)
		}
	}

	struct GeneralUser {
		let fullNam: String
		let phone: String
		let adress: String
		let zip: String
		let email: String
	}

	public func fetchData(collection: String, complition: @escaping (Category)-> Void) {
		db.collection(collection).getDocuments { (querySnapshot, error) in
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
						guard let data = data else {
							return
						}

						image = Image(withImage: data)
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
						guard let data = data else {
							return
						}
						imageView.image = UIImage(data: data)!
					}
				}
			}
		}
	}

	public func fetchMain(collection: String, complition: @escaping (Flower)-> Void) {
		db.collection(collection).getDocuments { (querySnapshot, error) in
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

	public func fetchItems(collection: String, field: String, complition: @escaping (Flower)-> Void) {
		guard let userEmail = userEmail else {return}
		let collection = db.collection(collection).document(userEmail)
		collection.getDocument { documentSnapshot, error in
			let cart = documentSnapshot?[field] as? [String]
			guard let cart = cart else {return}
			for i in 0..<cart.count {
				let collection = self.db.collection("Flowers").document(cart[i])
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

	public func addToDatabase(flower: Flower, field: TypeOfAction, complition: @escaping (Result<Void, Error>) -> Void) {
		guard let userEmail = userEmail else {return}
		let collection = db.collection(self.usersCollectionFirebase).document(userEmail)
		collection.getDocument { documentSnapshot, error in
			var favorite = documentSnapshot?[field.rawValue] as? [String]
			favorite?.append(flower.id)
			collection.updateData([field.rawValue : favorite ?? ""]) { error in
				if error != nil {
					complition(.failure(error!))
				} else {
					complition(.success(()))
				}
			}
		}
	}

	public func deliteFromDatabase(flower: Flower, field: TypeOfAction, complition: @escaping (Flower) -> Void) {
		guard let userEmail = userEmail else {return}
		let a = db.collection(self.usersCollectionFirebase).document(userEmail)
		complition(flower)
		a.updateData([
			field.rawValue : FieldValue.arrayRemove([flower.id])
		])
	}

	enum TypeOfAction: String {
		case cart = "cart"
		case favorite = "favorite"
	}
}
