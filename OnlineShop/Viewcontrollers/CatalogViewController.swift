//
//  TrendingViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire
import Firebase
import FirebaseFirestore
import FirebaseStorage

class CatalogViewController: UIViewController {

	let db = Firestore.firestore()
	var flowers = [Flower]()

	func fetchData() {
		db.collection("Flowers").getDocuments { (querySnapshot, error) in
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
						self.flowers.append(f)
						self.itemsCollection.reloadData()
					}
				}
			}
		}
	}

	func createCategoryButtons (title: String) -> UIButton {
		let button = UIButton()
		button.setTitle(title, for: .normal)
		button.titleLabel?.textAlignment = .center
		button.setTitleColor(Constants().greenColor, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()

	var sourceArray = [ProductInCart]()
	private lazy var itemsCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .vertical
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.backgroundColor = .systemBackground
		collection.clipsToBounds = true
		return collection
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		fetchData()
		view.addSubview(itemsCollection)
		view.addSubview(search)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		let allButton = createCategoryButtons(title: "All")
		view.addSubview(allButton)
		NSLayoutConstraint.activate([
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			allButton.topAnchor.constraint(equalTo: search.bottomAnchor),
			allButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			allButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),


			itemsCollection.topAnchor.constraint(equalTo: allButton.bottomAnchor),
			itemsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			itemsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return flowers.count
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
																ShopCollectionViewCell.identifier, for: indexPath)
				as? ShopCollectionViewCell else {
					return UICollectionViewCell()
				}
		if !flowers.isEmpty {
			cell.photoOfProduct.layer.cornerRadius = 10
			cell.photoOfProduct.image = flowers[indexPath.row].image?.getImage()
			cell.config(madel: flowers[indexPath.row])
		}
		cell.layer.cornerRadius = 20
		cell.layer.borderWidth = 0
		cell.layer.shadowColor = UIColor.systemGray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0, height: 0)
		cell.layer.shadowRadius = 8
		cell.layer.shadowOpacity = 0.5
		cell.layer.masksToBounds = false
		return cell
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width-20, height: view.frame.height/5-20)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 30
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = SingleItemViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
}

struct Flower: Codable {
	var description: String
	var image: Image?
	var price: String
	var title: String
	var type: String
	var id: String
}

struct Image: Codable {
  let imageData: Data?
  init(withImage image: Data) {
	self.imageData = image
  }
  func getImage() -> UIImage? {
	guard let imageData = self.imageData else {
	  return nil
	}
	let image = UIImage(data: imageData)
	return image
  }
}
