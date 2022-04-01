//
//  ItemCollectionViewCell.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
  static let identifier = "ItemCollectionViewCell"

	var placeLabel: UILabel = {
	  var lable = UILabel()
	  lable.textColor = .label
	  lable.lineBreakMode = .byWordWrapping
		lable.translatesAutoresizingMaskIntoConstraints = false
	  lable.lineBreakStrategy = .pushOut
	  lable.numberOfLines = 0
	  return lable
	}()

	var photoOfProduct: UIImageView = {
		var image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()

	override init(frame: CGRect) {
	  super.init(frame: frame)
		contentView.backgroundColor = .magenta

	  contentView.clipsToBounds = true
	  contentView.layer.cornerRadius = 10
	  addSubview(placeLabel)
		addSubview(photoOfProduct)
	}

	override func layoutSubviews() {
	  super.layoutSubviews()
//		NSLayoutConstraint.activate([
//			placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
//			placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//			placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//			placeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//		])

		NSLayoutConstraint.activate([
			photoOfProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
			photoOfProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			photoOfProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			photoOfProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])

	}

	required init?(coder: NSCoder) {
	  fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
	  super.prepareForReuse()
	  placeLabel.text = nil
	}
	
}
