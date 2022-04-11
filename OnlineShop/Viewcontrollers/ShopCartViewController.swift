//
//  ShopCartViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire
import Firebase

class ShopCartViewController: UIViewController {
var flowers = [Flower]()
	private lazy var itemsCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .vertical
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.backgroundColor = .systemBackground
		collection.clipsToBounds = true
		return collection
	}()

	var  payCartButton = UIButton().createCustomButton(title: "Buy")

	private lazy  var totalLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Total"
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().greenColor
		return title
	}()

	private lazy  var priceLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textAlignment = .right
		title.text = "$0"
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().greenColor
		return title
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(itemsCollection)
		view.addSubview(payCartButton)
		view.addSubview(totalLabel)
		view.addSubview(priceLabel)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		makeConstraints()
	}

	func makeConstraints() {
		NSLayoutConstraint.activate([
			itemsCollection.topAnchor.constraint(equalTo: view.topAnchor),
			itemsCollection.bottomAnchor.constraint(equalTo: totalLabel.topAnchor),
			itemsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			payCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			payCartButton.heightAnchor.constraint(equalToConstant: 50),
			payCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			payCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

			totalLabel.bottomAnchor.constraint(equalTo: payCartButton.topAnchor, constant: -10),
			totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			totalLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2),

			priceLabel.bottomAnchor.constraint(equalTo: payCartButton.topAnchor, constant: -10),
			priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			priceLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2),
		])
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
		self.flowers.removeAll()
		var totalPrice = Double(0)
		FirebaseManager.shered.fetchCartItem(collection: "users", field: "cart") { flower in
			self.flowers.append(flower)
			self.itemsCollection.reloadData()
			for flower in self.flowers {
				let a = Double(flower.price)
				totalPrice += Double(round(a ?? 0))
				self.priceLabel.text = String(totalPrice)
			}
		}
	}


	@objc func deliteFromCart(_ sender: IndexedButton) {
		print(sender.buttonIndexPath.row)
		FirebaseManager.shered.deliteFromCart(flower: flowers[sender.buttonIndexPath.row]) { flower in
			self.flowers.removeAll {
				$0.id == flower.id
			}
			self.itemsCollection.reloadData()
		}
	}

}


extension ShopCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.flowers.count
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
																CartCollectionViewCell.identifier, for: indexPath)
				as? CartCollectionViewCell else {
					return UICollectionViewCell()
				}
		cell.config(model: flowers[indexPath.row], indexPath: indexPath)
		cell.removeButton.addTarget(self, action: #selector(deliteFromCart), for: .touchUpInside)
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

		let flower = self.flowers[indexPath.row]
		var new = CatalogViewController.flowers
		new.removeAll {
			$0.type != flower.type
		}

		let vc = SingleItemViewController(flower: self.flowers[indexPath.row], flowerArray: new)
		navigationController?.pushViewController(vc, animated: true)
	}
}
