//
//  ItemCollectionViewCell.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
	static let identifier = "ItemCollectionViewCell"

	private lazy var placeLabel: UILabel = {
		var lable = UILabel()
		lable.textColor = .label
		lable.backgroundColor = .systemBackground
		lable.lineBreakMode = .byWordWrapping
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.lineBreakStrategy = .pushOut
		lable.numberOfLines = 0
		return lable
	}()

	private lazy var photoOfProduct: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = .magenta

		contentView.clipsToBounds = true
		contentView.layer.cornerRadius = 10
		photoOfProduct.addSubview(placeLabel)
		addSubview(photoOfProduct)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		placeLabel.text = nil
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		photoOfProduct.layer.cornerRadius = 10
		placeLabel.layer.cornerRadius = 3
		photoOfProduct.clipsToBounds = true
		placeLabel.clipsToBounds = true
		NSLayoutConstraint.activate([
			photoOfProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			photoOfProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
			photoOfProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			photoOfProduct.widthAnchor.constraint(equalToConstant: 200),
			photoOfProduct.heightAnchor.constraint(equalToConstant: 300),
			placeLabel.bottomAnchor.constraint(equalTo: photoOfProduct.bottomAnchor, constant:  -10),
			placeLabel.leadingAnchor.constraint(equalTo: photoOfProduct.leadingAnchor, constant: 30),
			placeLabel.widthAnchor.constraint(equalToConstant: 80),
		])
	}
	func confif(model: Category) {
		placeLabel.text = model.name
		photoOfProduct.image = model.image?.getImage()
	}
}
