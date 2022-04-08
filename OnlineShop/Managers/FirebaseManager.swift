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
				let id = queryDocumentSnapshot.documentID

				let storage = Storage.storage().reference()
				let fileRef = storage.child(path)
				fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
					if error == nil {
						image = Image(withImage: data!)
						let f = Flower(description: description, image: image, price: price, title: title, type: type, id: id)
						complition(f)
					}
				}
			}
		}
	}

	func fetch (document: String, completion: @escaping ([String : Any]) -> Void)  {
		db.collection(document).getDocuments { (querySnapshot, error) in
			guard let documents = querySnapshot?.documents else {
				print("No documents")
				return
			}
			documents.map { queryDocumentSnapshot in
				let	data = queryDocumentSnapshot.data()
				completion(data)
			}
		}
		//		firebaseManager.fetch(document: "Flowers") { data in
		//			var image: Image?
		//			let type = data["type"] as? String ?? ""
		//			let description = data["description"] as? String ?? ""
		//			let title = data["title"] as? String ?? ""
		//			let price = data["price"] as? String ?? ""
		//			let path = data["image"] as? String ?? ""
		//			let id = title
		//			let storage = Storage.storage().reference()
		//			let fileRef = storage.child(path)
		//			fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
		//				if error == nil {
		//					image = Image(withImage: data!)
		//					let f = Flower(description: description, image: image, price: price, title: title, type: type, id: id)
		//					self.flowers.append(f)
		//					self.itemsCollection.reloadData()
		//				}
		//			}
		//		}
	}
}
