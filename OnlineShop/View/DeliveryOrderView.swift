//
//  DeliveryOrderView.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 5.04.22.
//

import UIKit
import Firebase

class DeliveryOrderView: UIView {

	private lazy  var supportLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Support"
		title.textAlignment = .center
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().darkGreyColor
		return title
	}()

	private lazy  var suppordDescriptionLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.numberOfLines = 2
		title.text = "Let us know if you have any questions or problems with delivery"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().darkGreyColor
		return title
	}()

	private lazy  var suppordAccessebilityLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "9:00AM - 10:00PM"
		title.textAlignment = .right
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().greyColor
		return title
	}()

	private lazy var mainView: UIView = {
		let mainView = UIView()
		mainView.translatesAutoresizingMaskIntoConstraints = false
		mainView.backgroundColor = .systemBackground
		mainView.layer.cornerRadius = 20
		mainView.layer.borderWidth = 0
		mainView.layer.shadowColor = UIColor.systemGray.cgColor
		mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
		mainView.layer.shadowRadius = 8
		mainView.layer.shadowOpacity = 0.5
		mainView.layer.masksToBounds = false
		return mainView
	}()

	private lazy var contactsImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(systemName: "headphones")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var  chatButton: UIButton = {
		var button = UIButton()
		button.setTitle("Chat", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.backgroundColor = Constants().greenColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	private lazy var  phoneButton: UIButton = {
		var button = UIButton()
		button.setTitle("Phone", for: .normal)
		button.setTitleColor(Constants().greenColor, for: .normal)
		button.layer.borderWidth = 3
		button.layer.borderColor = CGColor(red: 0.33, green: 0.4, blue: 0.32, alpha: 0.8)
		button.clipsToBounds = true
		button.titleLabel?.textAlignment = .center
		button.backgroundColor = Constants().whiteColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		mainView.addSubview(supportLabel)
		mainView.addSubview(suppordDescriptionLabel)
		mainView.addSubview(suppordAccessebilityLabel)
		mainView.addSubview(contactsImage)
		mainView.addSubview(chatButton)
		mainView.addSubview(phoneButton)
		makeConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func makeConstraints() {
		NSLayoutConstraint.activate([
		chatButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
		chatButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/1.7),
		chatButton.heightAnchor.constraint(equalToConstant: 50),
		chatButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),

		phoneButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
		phoneButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/4),
		phoneButton.heightAnchor.constraint(equalToConstant: 50),
		phoneButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),

		contactsImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
		contactsImage.widthAnchor.constraint(equalToConstant: 50),
		contactsImage.heightAnchor.constraint(equalToConstant: 50),
		contactsImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),

		supportLabel.leadingAnchor.constraint(equalTo: contactsImage.trailingAnchor, constant: 10),
		supportLabel.trailingAnchor.constraint(equalTo: suppordAccessebilityLabel.leadingAnchor),
		supportLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),

		suppordDescriptionLabel.leadingAnchor.constraint(equalTo: contactsImage.trailingAnchor, constant: 10),
		suppordDescriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
		suppordDescriptionLabel.topAnchor.constraint(equalTo: supportLabel.bottomAnchor, constant: 5),
		suppordDescriptionLabel.bottomAnchor.constraint(equalTo: chatButton.topAnchor, constant: -5),

		suppordAccessebilityLabel.leadingAnchor.constraint(equalTo: supportLabel.trailingAnchor, constant: 10),
		suppordAccessebilityLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
		suppordAccessebilityLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
		])
	}
}
