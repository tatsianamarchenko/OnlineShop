//
//  FavoriteViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 1.04.22.
//

import UIKit
import Alamofire

class FavoriteViewController: UIViewController {

	var flowers = [Flower]()

	private lazy var itemsCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .vertical
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.backgroundColor = .systemBackground
		collection.clipsToBounds = true
		return collection
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
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
		self.flowers.removeAll()
		var totalPrice = Double(0)
		FirebaseManager.shered.fetchCartItem(collection: "users", field: "favorite") { flower in
			self.flowers.append(flower)
			self.itemsCollection.reloadData()
		}
	}

	@objc func deliteFromFavorite(_ sender: IndexedButton) {
		print(sender.buttonIndexPath.row)
		FirebaseManager.shered.deliteFromFavorite(flower: flowers[sender.buttonIndexPath.row]) { flower in
			self.flowers.removeAll {
				$0.id == flower.id
			}
			self.itemsCollection.reloadData()
		}
	}

}


	extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

		func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
			return self.flowers.count
		}

		func numberOfSections(in collectionView: UICollectionView) -> Int {
			return 1
		}

		func collectionView(_ collectionView: UICollectionView,
							cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
																	FavoriteCollectionViewCell.identifier, for: indexPath)
					as? FavoriteCollectionViewCell else {
						return UICollectionViewCell()
					}
			cell.config(model: flowers[indexPath.row], indexPath: indexPath)
			cell.removeButton.addTarget(self, action: #selector(deliteFromFavorite), for: .touchUpInside
			)
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
			let vc = SingleItemViewController(flower: nil, flowerArray: nil)
			navigationController?.pushViewController(vc, animated: true)
		}
	}
