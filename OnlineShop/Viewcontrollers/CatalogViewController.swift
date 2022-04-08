//
//  TrendingViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class CatalogViewController: UIViewController {

	var flowers = [Flower]()
	var firebaseManager = FirebaseManager()
	func createCategoryButtons (title: String) -> UIButton {
		let button = UIButton()
		button.setTitle(title, for: .normal)
		button.titleLabel?.textAlignment = .center
		button.setTitleColor(Constants().greenColor, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	var scView: UIScrollView = {
		var scView = UIScrollView(frame:.zero)
		scView.translatesAutoresizingMaskIntoConstraints = false
		scView.showsVerticalScrollIndicator = false
		scView.showsHorizontalScrollIndicator = false
		return scView
	}()

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

	func loadInfo() {
		self.flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			self.flowers.append(flower)
			self.scView.reloadInputViews()
			self.itemsCollection.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		loadInfo()
		view.addSubview(itemsCollection)
		view.addSubview(search)
		view.addSubview(scView)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		let buttonPadding:CGFloat = 10
		var xOffset:CGFloat = 10
		let buttonNameArray = ["All", "Living room", "Bathroom", "Bedroom", "Kitchen"]

		for (index, value) in buttonNameArray.enumerated() {
			let button = UIButton()
			button.accessibilityIdentifier = value
			button.setTitle(value, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 20)
			button.addTarget(self, action: #selector(btnTouch), for: .touchUpInside)
			button.titleLabel?.textAlignment = .center
			button.setTitleColor(Constants().greenColor, for: .normal)
			button.setTitleColor(Constants().darkGreyColor, for: .selected)
			button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
			xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
			scView.addSubview(button)
			scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
		}
		makeConstants()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}
	@objc func btnTouch(_ button: UIButton) {
		self.flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			switch button.accessibilityIdentifier {
			case "All":
				self.flowers.append(flower)
				self.itemsCollection.reloadData()
			case "Living room":
				if flower.type == "Living room" {
				self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Bathroom":
				if flower.type == "Bathroom" {
				self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Bedroom":
				if flower.type == "Bedroom" {
				self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Kitchen":
				if flower.type == "Kitchen" {
					self.flowers.append(flower)
					self.itemsCollection.reloadData()
				}
			default: 	break
			}
		}
	}
//	func createArray(new: String) -> [String] {
//		if !buttonNameArray.contains(new) {
//			buttonNameArray.append(new)
//		}
//		print(buttonNameArray)
//		return buttonNameArray
//	}

	func makeConstants() {

		NSLayoutConstraint.activate([
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			scView.topAnchor.constraint(equalTo: search.bottomAnchor),
			scView.bottomAnchor.constraint(equalTo: itemsCollection.topAnchor),
			scView.heightAnchor.constraint(equalToConstant: 50),
			scView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			itemsCollection.topAnchor.constraint(equalTo: scView.bottomAnchor),
			itemsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			itemsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
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
