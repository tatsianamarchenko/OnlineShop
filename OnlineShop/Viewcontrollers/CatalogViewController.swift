//
//  TrendingViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire

class CatalogViewController: UIViewController {
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
		loadInfo()
		view.addSubview(itemsCollection)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		makeConstraints()
	}

	func makeConstraints() {
		NSLayoutConstraint.activate([
			itemsCollection.topAnchor.constraint(equalTo: view.topAnchor),
			itemsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			itemsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}

	func loadInfo() {
		AF.request("https://fakestoreapi.com/carts")
		  .validate()
		  .responseDecodable(of: [CartModel].self) { (response) in
			  guard let productsInCart = response.value else { return }
			  self.sourceArray = productsInCart[0].products
			  self.itemsCollection.reloadData()
		  }
	}
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
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
		cell.nameLabel.text = "Lavander"
		cell.photoOfProduct.layer.cornerRadius = 10
		cell.photoOfProduct.downloadedFrom(url: CategoriesViewController.contentArray[indexPath.row].image)
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