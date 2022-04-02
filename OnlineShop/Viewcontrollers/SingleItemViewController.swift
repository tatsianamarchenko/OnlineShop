//
//  SingleItemViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class SingleItemViewController: UIViewController {
	var fav = false
	private lazy var productImageView: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.backgroundColor = .systemGray3
		image.image = UIImage(named: "lavanda")
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var flowerView: UIView = {
		var view = UIView()
		return view
	}()

	var addToCartButton: UIButton = {
		var button = UIButton()
		button.setTitle("add to cart", for: .normal)
		button.backgroundColor = .systemGreen
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private lazy var bacisInformationStackView: UIStackView = {
		var image = UIImageView(image: UIImage(systemName: "drop"))
		image.backgroundColor = .systemGreen
		image.layer.cornerRadius = 3
		image.clipsToBounds = true
		image.contentMode = .center
		var lable = UILabel()
		lable.text = "lol"
		lable.textAlignment = .right
		var stack = UIStackView(arrangedSubviews: [image, lable])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .darkGray
		stack.axis = .horizontal
		stack.alignment = .center
		return stack
	}()

	func createBacicInformationImage (string: String) -> UIImageView {
		let image = UIImageView(image: UIImage(systemName: string)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal))
			image.backgroundColor = .systemGray6
			image.layer.cornerRadius = 3
			image.translatesAutoresizingMaskIntoConstraints = false
			image.clipsToBounds = true
			image.contentMode = .center
			return image
	}

	private lazy  var priceLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = .systemBlue
		return title
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(productImageView)
		view.addSubview(priceLabel)
		//view.addSubview(bacisInformationStackView)
		let hudrationImage = createBacicInformationImage(string: "drop")
		let sunImage = createBacicInformationImage(string: "sun.min")
		let temperatureImage = createBacicInformationImage(string: "thermometer")
		view.addSubview(hudrationImage)
		view.addSubview(sunImage)
		view.addSubview(temperatureImage)
		view.addSubview(addToCartButton)
		view.backgroundColor = .systemBackground
		createBar()
		NSLayoutConstraint.activate([
			productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			productImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2),
			productImageView.heightAnchor.constraint(equalToConstant: view.frame.height/2),
			hudrationImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: 80),
			hudrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			hudrationImage.widthAnchor.constraint(equalToConstant: 50),
			hudrationImage.heightAnchor.constraint(equalToConstant: 50),

			sunImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
			sunImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			sunImage.widthAnchor.constraint(equalToConstant: 50),
			sunImage.heightAnchor.constraint(equalToConstant: 50),

			temperatureImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: -80),
			temperatureImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			temperatureImage.widthAnchor.constraint(equalToConstant: 50),
			temperatureImage.heightAnchor.constraint(equalToConstant: 50),

			addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			addToCartButton.heightAnchor.constraint(equalToConstant: 50),
			addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width/2),
			addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
		])
	}

	func createBar() {
		title = "lavanda"
		tabBarController?.tabBar.isHidden = true
		let saveImage = UIImage(systemName: "heart")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
		guard let saveImage = saveImage else {
			return
		}
		let button = UIBarButtonItem(image: saveImage,
									 style: .plain,
									 target: self,
									 action: #selector(addToFavorte))

		navigationItem.rightBarButtonItem = button
	}

	@objc func addToFavorte(_ sender: UIBarButtonItem) {
		fav.toggle()
		let unfavImage = UIImage(systemName: "heart")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
		guard let unfavImage = unfavImage else {
			return
		}
		let favImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
		guard let favImage = favImage else {
			return
		}
		if fav == true {
			sender.image = unfavImage

		} else {
			sender.image = favImage
		}
	}
}
