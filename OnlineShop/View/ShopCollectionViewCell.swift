//
//  ShopCollectionViewCell.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 5.04.22.
//

import UIKit
import Firebase

class ShopCollectionViewCell: UICollectionViewCell {

	 static let identifier = "ShopCollectionViewCell"

	 var nameLabel: UILabel = {
		 var lable = UILabel()
		 lable.textColor = Constants().darkGreyColor
		 lable.font = .systemFont(ofSize: 20, weight: .medium)
		 lable.backgroundColor = .systemBackground
		 lable.lineBreakMode = .byWordWrapping
		 lable.translatesAutoresizingMaskIntoConstraints = false
		 lable.lineBreakStrategy = .pushOut
		 lable.numberOfLines = 0
		 return lable
	 }()

	 var  favoriteButton: IndexedButton = {
		 var button = IndexedButton(buttonIndexPath: IndexPath(index: 0))
		 button.setImage(UIImage(systemName: "heart")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal), for: .normal)
		 button.addTarget(self, action: #selector(toFavorite), for: .touchUpInside)
		 button.titleLabel?.textAlignment = .center
		 button.translatesAutoresizingMaskIntoConstraints = false
		 return button
	 }()

	 private lazy var typeLable : UILabel = {
		 var lable = UILabel()
		 lable.font = .systemFont(ofSize: 15, weight: .regular)
		 lable.translatesAutoresizingMaskIntoConstraints = false
		 lable.textColor = Constants().darkGreyColor
		 lable.text = "For Bathroom"
		 return lable
	 }()

	 private lazy var priceLable : UILabel = {
		 var lable = UILabel()
		 lable.font = .systemFont(ofSize: 20, weight: .medium)
		 lable.translatesAutoresizingMaskIntoConstraints = false
		 lable.textColor = Constants().darkGreyColor
		 lable.textAlignment = .right
		 return lable
	 }()

	 private lazy var descriptionLable : UILabel = {
		 var lable = UILabel()
		 lable.translatesAutoresizingMaskIntoConstraints = false
		 lable.numberOfLines = 2
		 lable.font = .systemFont(ofSize: 15)
		 return lable
	 }()

	private lazy var photoOfProduct: UIImageView = {
		 var image = UIImageView()
		 image.translatesAutoresizingMaskIntoConstraints = false
		 image.contentMode = .scaleToFill
		 return image
	 }()


	@objc func toFavorite(_ sender: IndexedButton) {
		let index = sender.buttonIndexPath.row
		let db = Firestore.firestore()
		guard let user = Auth.auth().currentUser?.email else {return}
		var collection = db.collection("users").document(user)
		collection.getDocument { documentSnapshot, error in
			var favorite = documentSnapshot?["favorite"] as? [String]
			favorite?.append(CatalogViewController.flowers[sender.buttonIndexPath.row].id)
			collection.updateData(["favorite": favorite]) { error in
				if error != nil {
					self.createAlert(string: error?.localizedDescription ?? "")
				} else {
					self.createAlert(string: "Added to favorite")
				}

			}
		}
	}

	func createAlert(string: String) {
		let alert = UIAlertController(title: "Added", message: string, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
		if let vc = self.next(ofType: UIViewController.self) {
			vc.present(alert, animated: true, completion: nil)
		}
	}


	func config(madel: Flower, indexPath: IndexPath) {
		nameLabel.text = madel.title
		descriptionLable.text = madel.description
		typeLable.text = madel.type
		priceLable.text = ("$\(madel.price)")
		photoOfProduct.image = madel.image?.getImage()
		favoriteButton.buttonIndexPath = indexPath
	}

	 override init(frame: CGRect) {
		 super.init(frame: frame)
		 contentView.backgroundColor = .systemBackground
		 contentView.clipsToBounds = true
		 contentView.layer.cornerRadius = 10
		 addSubview(nameLabel)
		 addSubview(photoOfProduct)
		 addSubview(descriptionLable)
		 addSubview(typeLable)
		 addSubview(priceLable)
		 addSubview(favoriteButton)
		 makeConstants()
	 }

	 override func layoutSubviews() {
		 super.layoutSubviews()
		 photoOfProduct.layer.cornerRadius = 10
		 photoOfProduct.clipsToBounds = true
	 }

	 func makeConstants() {
		 NSLayoutConstraint.activate([
			 photoOfProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			 photoOfProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
			 photoOfProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			 photoOfProduct.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
			 photoOfProduct.heightAnchor.constraint(equalToConstant: contentView.frame.height),

			 nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
			 nameLabel.leadingAnchor.constraint(equalTo: photoOfProduct.trailingAnchor, constant: 10),
			 typeLable.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
			 typeLable.leadingAnchor.constraint(equalTo: photoOfProduct.trailingAnchor, constant: 10),

			 descriptionLable.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: 5),
			 descriptionLable.leadingAnchor.constraint(equalTo: photoOfProduct.trailingAnchor, constant: 10),
			 descriptionLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			 descriptionLable.widthAnchor.constraint(equalToConstant: contentView.frame.width/1.7),

			 priceLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			 priceLable.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
			 priceLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 5),
			 priceLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			 favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			 favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
		 ])
	 }

	 required init?(coder: NSCoder) {
		 fatalError("init(coder:) has not been implemented")
	 }

	 override func prepareForReuse() {
		 super.prepareForReuse()
		 nameLabel.text = nil
	 }

 }
