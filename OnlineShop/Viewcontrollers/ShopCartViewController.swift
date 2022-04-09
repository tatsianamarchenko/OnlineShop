//
//  ShopCartViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire

class ShopCartViewController: UIViewController {
	var sourceArray = [ProductInCart]()

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

	var  payCartButton: UIButton = {
		var button = UIButton()
		button.setTitle("Buy", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.backgroundColor = Constants().greenColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

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
		loadInfo()
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


extension ShopCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
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
		cell.nameLabel.text = "Lavander"
		cell.photoOfProduct.layer.cornerRadius = 10
		cell.photoOfProduct.image = UIImage(named: "lol")
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
