//
//  ItemCollectionViewCell.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import GMStepper

class CartCollectionViewCell: UICollectionViewCell {
	static let identifier = "CartCollectionViewCell"

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
		lable.backgroundColor = .systemMint
		lable.font = .systemFont(ofSize: 20, weight: .medium)
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textColor = Constants().darkGreyColor
		lable.textAlignment = .right
		lable.text = "$100"
		return lable
	}()

	private lazy var descriptionLable : UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.numberOfLines = 2
		lable.font = .systemFont(ofSize: 15)
		lable.text = "Lavender plants are small, branching and spreading shrubs with grey-green leaves and long flowering shoots. The leaves can be simple or pinnate measuring 30–50 mm (1–2 in) in length. The plant produces flowers on shoots or spikes which can be 20–40 cm (8–16 in) long. The flowers are lilac or blue in color."
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
		addSubview(priceLable)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		photoOfProduct.layer.cornerRadius = 10
		photoOfProduct.clipsToBounds = true
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

			priceLable.leadingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: 10),
			priceLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			priceLable.widthAnchor.constraint(equalToConstant: contentView.frame.width/3),
			priceLable.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 5),
			priceLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

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
