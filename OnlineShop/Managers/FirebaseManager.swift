//
//  FirebaseManager.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 8.04.22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager {

	let db = Firestore.firestore()

	func fetchData(document: String, complition: @escaping (Category)-> Void) {
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

	func fetchImage(collection: String, imageView: UIImageView) {
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


	func fetchMain(document: String, complition: @escaping (Flower)-> Void) {
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

	func fetchCartItem(collection: String, field: String, complition: @escaping (Flower)-> Void) {
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
}
