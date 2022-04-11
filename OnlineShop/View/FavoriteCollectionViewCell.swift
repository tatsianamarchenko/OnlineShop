//
//  FavoriteCollectionViewCell.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 5.04.22.
//

import UIKit
import GMStepper
import Firebase

class FavoriteCollectionViewCell: UICollectionViewCell {

	static let identifier = "FavoriteCollectionViewCell"
	var flower: Flower?
	private lazy var nameLabel: UILabel = {
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

	var  removeButton: IndexedButton = {
		var button = IndexedButton(buttonIndexPath: IndexPath(index: 0))
		button.setImage(UIImage(systemName: "xmark.bin")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal), for: .normal)
		button.titleLabel?.textAlignment = .center
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	private lazy var typeLable : UILabel = {
		var lable = UILabel()
		lable.font = .systemFont(ofSize: 15, weight: .regular)
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textColor = Constants().darkGreyColor
		return lable
	}()
	
	var  addToCartButton = UIButton().createCustomButton(title: "$0")

	private lazy var descriptionLable : UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.numberOfLines = 2
		lable.font = .systemFont(ofSize: 15)
		return lable
	}()
	private lazy var stepper: GMStepper = {
		var stepper = GMStepper()
		stepper.maximumValue = 100
		stepper.minimumValue = 1
		stepper.buttonsTextColor = Constants().greyColor

		stepper.buttonsBackgroundColor = Constants().whiteColor
		stepper.limitHitAnimationColor = Constants().greyColor
		stepper.labelBackgroundColor = .systemBackground
		stepper.labelTextColor = Constants().greyColor
		stepper.labelFont = .systemFont(ofSize: 15, weight: .medium)
		stepper.tintColor = Constants().greyColor
		stepper.translatesAutoresizingMaskIntoConstraints = false
		stepper.stepValue = 1
		return stepper
	}()

	func config(model: Flower, indexPath: IndexPath) {
		nameLabel.text = model.title
		typeLable.text = model.type
		descriptionLable.text = model.description
		addToCartButton.setTitle(model.price, for: .normal)
		photoOfProduct.image = model.image?.getImage()
		flower = model
		addToCartButton.buttonIndexPath = indexPath
		removeButton.buttonIndexPath = indexPath
		addToCartButton.addTarget(self, action: #selector(toCart), for: .touchUpInside)
	}


	var photoOfProduct: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .systemBackground
		contentView.clipsToBounds = true
		contentView.layer.cornerRadius = 10
		addSubview(nameLabel)
		addSubview(photoOfProduct)
		addSubview(descriptionLable)
		addSubview(typeLable)
		addSubview(stepper)
		addSubview(removeButton)
		addSubview(addToCartButton)
		makeConstants()
	}

	@objc func toCart(_ sender: IndexedButton) {
		FirebaseManager.shered.addToCart(flower: self.flower!) { (result: Result<Void, Error>) in
			switch result {
			case .success():
				self.createAlert(string: "Added to cart")
			case .failure(let error):
				self.createAlert(string: error.localizedDescription)
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
			descriptionLable.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),

			stepper.leadingAnchor.constraint(equalTo: photoOfProduct.trailingAnchor, constant: 10),
			stepper.widthAnchor.constraint(equalToConstant: contentView.frame.width/4),
			stepper.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 5),
			stepper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			addToCartButton.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 10),
			addToCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			addToCartButton.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
			addToCartButton.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 5),
			addToCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			removeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
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

extension UIResponder {
	func next<T:UIResponder>(ofType: T.Type) -> T? {
		let r = self.next
		if let r = r as? T ?? r?.next(ofType: T.self) {
			return r
		} else {
			return nil
		}
	}
}
