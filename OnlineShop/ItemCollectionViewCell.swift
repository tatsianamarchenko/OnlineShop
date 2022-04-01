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
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit
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
		NSLayoutConstraint.activate([
			photoOfProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			photoOfProduct.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			photoOfProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			photoOfProduct.widthAnchor.constraint(equalToConstant: 300),
			photoOfProduct.heightAnchor.constraint(equalToConstant: 300)
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
