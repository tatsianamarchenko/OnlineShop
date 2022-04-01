//
//  ContactCell.swift
//  ThirdProject
//
//  Created by Tatsiana Marchanka on 15.02.22.
//

import UIKit

class CartCell: UITableViewCell {

  static var cellIdentifier = "CartCell"

	private lazy var productImageView: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.backgroundColor = .systemGray3
		image.contentMode = .scaleAspectFill
		return image
	}()

	private lazy  var priceLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = .systemBlue
		return title
	}()

	private lazy  var quantityLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = .systemBlue
		return title
	}()

	private lazy var descriptionLabel: UILabel = {
		var descrip = UILabel()
		descrip.lineBreakMode = .byWordWrapping
		descrip.lineBreakStrategy = .pushOut
		descrip.numberOfLines = 0
		descrip.translatesAutoresizingMaskIntoConstraints = false
		descrip.font = UIFont.systemFont(ofSize: 15)
		descrip.textColor = .systemMint
		return descrip
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(productImageView)
		contentView.addSubview(priceLabel)
		contentView.addSubview(quantityLabel)


		NSLayoutConstraint.activate([
			priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
			priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			quantityLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
			quantityLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
			descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),

			productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			productImageView.topAnchor.constraint(equalTo: priceLabel.topAnchor),
			productImageView.widthAnchor.constraint(equalToConstant: 90),
			productImageView.heightAnchor.constraint(equalToConstant: 100)
		])
	}

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
	  productImageView.layer.masksToBounds = true
	  productImageView.layer.cornerRadius = 10
  }
	func config(model: ProductInCart) {

		let product = CategoriesViewController.contentArray[model.productID-1]
		descriptionLabel.text = String(product.title)
		priceLabel.text = String("$\(product.price)")
		quantityLabel.text = String("QTY:\(model.quantity)")
		productImageView.downloadedFrom(url: product.image)
	}
}
