//
//  ProfileViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 4.04.22.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

	private lazy var  chatButton = UIButton().createCustomButton(title: "chat")
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

	private lazy  var namelLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.textAlignment = .center
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().darkGreyColor
		return title
	}()

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

	private lazy  var adressLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.numberOfLines = 2
		lable.font = .systemFont(ofSize: 15)
		lable.text = "Lavender plants are small, branching and spreading shrubs with grey-green leaves and long flowering shoots. The leaves can be simple or pinnate measuring 30–50 mm (1–2 in) in length. The plant produces flowers on shoots or spikes which can be 20–40 cm (8–16 in) long. The flowers are lilac or blue in color."
		return lable
	}()

	private lazy  var deliveryTimeLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "19 Apr 2021, 5:10PM"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().greyColor
		return title
	}()

	private lazy  var deliveryItemsLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "3 items"
		title.textAlignment = .right
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().greyColor
		return title
	}()

	private lazy  var deliveryLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Order: 1"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 20)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy  var estimatedDeliveryItemsLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Estimated Delivery on 21 Apr"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().greenColor
		return title
	}()

	private lazy var photoOfProfile: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(named: "lol")
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var contactsImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(systemName: "headphones")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var deliveryImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(systemName: "list.dash.header.rectangle")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy  var ordersLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Orders"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 20)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy var  actualButton: UIButton = {
		var button = UIButton()
		button.setTitle("Active", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.setTitleColor(Constants().greenColor, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	private lazy var  historyButton: UIButton = {
		var button = UIButton()
		button.setTitle("History", for: .normal)
		button.titleLabel?.textAlignment = .center
		button.setTitleColor(Constants().greenColor, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	private lazy  var paymentLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Payment"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().darkGreyColor
		return title
	}()

	private lazy  var cardNumberLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "*** *** *** 1234"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 20)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy  var cardTimeLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "09/21"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 15)
		title.textColor = Constants().greenColor
		return title
	}()

	private lazy var visaOrmastercardImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(named: "lol")
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var envelopeImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(systemName: "envelope")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy  var mailLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "lox@mail.ru"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 15)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy  var advertesingMailLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Advertesing and promotion"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 15)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy var phoneImage: UIImageView = {
		var image = UIImageView()
		image.image = UIImage(systemName: "iphone.smartbatterycase.gen2")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy  var phoneLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "+234657890"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 15)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy  var advertesingPhoneLabel: UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Advertesing and promotion"
		lable.textAlignment = .left
		lable.font = UIFont.systemFont(ofSize: 15)
		lable.textColor = Constants().darkGreyColor
		return lable
	}()

	private lazy var contactsView = UIView().createCustomView()
	private lazy var orderView = UIView().createCustomView()
	private lazy var cardView = UIView().createCustomView()
	private lazy var profileContactsView = UIView().createCustomView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubview(photoOfProfile)
		view.addSubview(contactsView)
		view.addSubview(orderView)
		view.addSubview(cardView)
		view.addSubview(profileContactsView)
		view.addSubview(namelLabel)
		view.addSubview(adressLabel)
		view.addSubview(ordersLabel)
		view.addSubview(actualButton)
		view.addSubview(historyButton)
		contactsView.addSubview(chatButton)
		contactsView.addSubview(phoneButton)
		contactsView.addSubview(contactsImage)
		contactsView.addSubview(supportLabel)
		contactsView.addSubview(suppordDescriptionLabel)
		contactsView.addSubview(suppordAccessebilityLabel)

		orderView.addSubview(deliveryImage)
		orderView.addSubview(deliveryLabel)
		orderView.addSubview(deliveryTimeLabel)
		orderView.addSubview(deliveryItemsLabel)
		orderView.addSubview(estimatedDeliveryItemsLabel)

		cardView.addSubview(paymentLabel)
		cardView.addSubview(cardTimeLabel)
		cardView.addSubview(visaOrmastercardImage)
		cardView.addSubview(cardNumberLabel)

		profileContactsView.addSubview(envelopeImage)
		profileContactsView.addSubview(phoneImage)
		profileContactsView.addSubview(advertesingMailLabel)
		profileContactsView.addSubview(advertesingPhoneLabel)
		profileContactsView.addSubview(phoneLabel)
		profileContactsView.addSubview(mailLabel)
		createBarButton()
		NSLayoutConstraint.activate([
			contactsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			contactsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			contactsView.heightAnchor.constraint(equalToConstant: view.frame.height/6),
			contactsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

			orderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			orderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			orderView.heightAnchor.constraint(equalToConstant: view.frame.height/10),
			orderView.bottomAnchor.constraint(equalTo: contactsView.topAnchor, constant: -10),

			ordersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			ordersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			ordersLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor),
			ordersLabel.bottomAnchor.constraint(equalTo: actualButton.topAnchor),

			actualButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			actualButton.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor),
			actualButton.bottomAnchor.constraint(equalTo: orderView.topAnchor),

			historyButton.leadingAnchor.constraint(equalTo: actualButton.trailingAnchor, constant: 10),
			historyButton.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor),
			historyButton.bottomAnchor.constraint(equalTo: orderView.topAnchor),

			cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			cardView.heightAnchor.constraint(equalToConstant: view.frame.height/10),
			cardView.bottomAnchor.constraint(equalTo: ordersLabel.topAnchor, constant: -10),

			visaOrmastercardImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
			visaOrmastercardImage.widthAnchor.constraint(equalToConstant: 50),
			visaOrmastercardImage.heightAnchor.constraint(equalToConstant: 30),
			visaOrmastercardImage.topAnchor.constraint(equalTo: paymentLabel.centerYAnchor, constant: 10),

			paymentLabel.leadingAnchor.constraint(equalTo: visaOrmastercardImage.trailingAnchor, constant: 10),
			paymentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			paymentLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),

			cardNumberLabel.leadingAnchor.constraint(equalTo: visaOrmastercardImage.trailingAnchor, constant: 10),
			cardNumberLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			cardNumberLabel.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 5),
			cardNumberLabel.bottomAnchor.constraint(equalTo: cardTimeLabel.topAnchor, constant: -5),

			cardTimeLabel.leadingAnchor.constraint(equalTo: visaOrmastercardImage.trailingAnchor, constant: 10),
			cardTimeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			cardTimeLabel.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 10),
			cardTimeLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5),

			profileContactsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			profileContactsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			profileContactsView.heightAnchor.constraint(equalToConstant: view.frame.height/9),
			profileContactsView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -20),

			phoneImage.leadingAnchor.constraint(equalTo: profileContactsView.leadingAnchor, constant: 10),
			phoneImage.widthAnchor.constraint(equalToConstant: 20),
			phoneImage.heightAnchor.constraint(equalToConstant: 20),
			phoneImage.topAnchor.constraint(equalTo: profileContactsView.topAnchor, constant: 10),

			phoneLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 10),
			phoneLabel.trailingAnchor.constraint(equalTo: profileContactsView.trailingAnchor, constant: -10),
			phoneLabel.topAnchor.constraint(equalTo: profileContactsView.topAnchor, constant: 10),

			advertesingPhoneLabel.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 10),
			advertesingPhoneLabel.trailingAnchor.constraint(equalTo: profileContactsView.trailingAnchor, constant: -10),
			advertesingPhoneLabel.topAnchor.constraint(equalTo: phoneImage.bottomAnchor),
			advertesingPhoneLabel.bottomAnchor.constraint(equalTo: mailLabel.topAnchor, constant: -10),

			envelopeImage.leadingAnchor.constraint(equalTo: profileContactsView.leadingAnchor, constant: 10),
			envelopeImage.widthAnchor.constraint(equalToConstant: 20),
			envelopeImage.heightAnchor.constraint(equalToConstant: 20),
			envelopeImage.topAnchor.constraint(equalTo: mailLabel.centerYAnchor, constant: -10),

			mailLabel.leadingAnchor.constraint(equalTo: envelopeImage.trailingAnchor, constant: 10),
			mailLabel.trailingAnchor.constraint(equalTo: profileContactsView.trailingAnchor, constant: -10),
			mailLabel.topAnchor.constraint(equalTo: advertesingPhoneLabel.bottomAnchor, constant: -5),

			advertesingMailLabel.leadingAnchor.constraint(equalTo: envelopeImage.trailingAnchor, constant: 10),
			advertesingMailLabel.trailingAnchor.constraint(equalTo: profileContactsView.trailingAnchor, constant: -10),
			advertesingMailLabel.topAnchor.constraint(equalTo: mailLabel.bottomAnchor),
			advertesingMailLabel.bottomAnchor.constraint(equalTo: profileContactsView.bottomAnchor, constant: -5),

			deliveryImage.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 10),
			deliveryImage.widthAnchor.constraint(equalToConstant: 50),
			deliveryImage.heightAnchor.constraint(equalToConstant: 50),
			deliveryImage.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 10),

			deliveryLabel.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 10),
			deliveryLabel.trailingAnchor.constraint(equalTo: deliveryItemsLabel.leadingAnchor),
			deliveryLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 5),

			deliveryTimeLabel.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 10),
			deliveryTimeLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -10),
			deliveryTimeLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor, constant: 5),
			deliveryTimeLabel.bottomAnchor.constraint(equalTo: estimatedDeliveryItemsLabel.topAnchor, constant: -5),

			deliveryItemsLabel.leadingAnchor.constraint(equalTo: deliveryLabel.trailingAnchor, constant: 10),
			deliveryItemsLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -20),
			deliveryItemsLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 10),

			estimatedDeliveryItemsLabel.leadingAnchor.constraint(equalTo: deliveryImage.trailingAnchor, constant: 10),
			estimatedDeliveryItemsLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -10),
			estimatedDeliveryItemsLabel.bottomAnchor.constraint(equalTo: orderView.bottomAnchor, constant: -10),

			photoOfProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			photoOfProfile.widthAnchor.constraint(equalToConstant: view.frame.width/4),
			photoOfProfile.heightAnchor.constraint(equalToConstant: 100),
			photoOfProfile.bottomAnchor.constraint(equalTo: profileContactsView.topAnchor, constant: -20),

			namelLabel.leadingAnchor.constraint(equalTo: photoOfProfile.trailingAnchor, constant: 20),
			namelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			namelLabel.topAnchor.constraint(equalTo: photoOfProfile.topAnchor),

			adressLabel.leadingAnchor.constraint(equalTo: photoOfProfile.trailingAnchor, constant: 20),
			adressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			adressLabel.topAnchor.constraint(equalTo: namelLabel.bottomAnchor, constant: 10),


			chatButton.leadingAnchor.constraint(equalTo: contactsView.leadingAnchor, constant: 10),
			chatButton.widthAnchor.constraint(equalToConstant: view.frame.width/1.7),
			chatButton.heightAnchor.constraint(equalToConstant: 50),
			chatButton.bottomAnchor.constraint(equalTo: contactsView.bottomAnchor, constant: -10),

			phoneButton.trailingAnchor.constraint(equalTo: contactsView.trailingAnchor, constant: -10),
			phoneButton.widthAnchor.constraint(equalToConstant: view.frame.width/4),
			phoneButton.heightAnchor.constraint(equalToConstant: 50),
			phoneButton.bottomAnchor.constraint(equalTo: contactsView.bottomAnchor, constant: -10),

			contactsImage.leadingAnchor.constraint(equalTo: contactsView.leadingAnchor, constant: 10),
			contactsImage.widthAnchor.constraint(equalToConstant: 50),
			contactsImage.heightAnchor.constraint(equalToConstant: 50),
			contactsImage.topAnchor.constraint(equalTo: contactsView.topAnchor, constant: 10),

			supportLabel.leadingAnchor.constraint(equalTo: contactsImage.trailingAnchor, constant: 10),
			supportLabel.trailingAnchor.constraint(equalTo: suppordAccessebilityLabel.leadingAnchor),
			supportLabel.topAnchor.constraint(equalTo: contactsView.topAnchor, constant: 5),

			suppordDescriptionLabel.leadingAnchor.constraint(equalTo: contactsImage.trailingAnchor, constant: 10),
			suppordDescriptionLabel.trailingAnchor.constraint(equalTo: contactsView.trailingAnchor, constant: -10),
			suppordDescriptionLabel.topAnchor.constraint(equalTo: supportLabel.bottomAnchor, constant: 5),
			suppordDescriptionLabel.bottomAnchor.constraint(equalTo: chatButton.topAnchor, constant: -5),

			suppordAccessebilityLabel.leadingAnchor.constraint(equalTo: supportLabel.trailingAnchor, constant: 10),
			suppordAccessebilityLabel.trailingAnchor.constraint(equalTo: contactsView.trailingAnchor, constant: -20),
			suppordAccessebilityLabel.topAnchor.constraint(equalTo: contactsView.topAnchor, constant: 10),

		])
		config()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		photoOfProfile.layer.cornerRadius = 10
		photoOfProfile.clipsToBounds = true
	}

	private func config() {
		guard let user = Auth.auth().currentUser else {return}
		namelLabel.text = user.email
	}

	private func createBarButton() {
	  let saveImage = UIImage(systemName: "person.crop.circle.badge.minus")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
	  guard let saveImage = saveImage else {
		return
	  }
	  let button = UIBarButtonItem(image: saveImage,
								   style: .plain,
								   target: self,
								   action: #selector(reset))

	  navigationItem.rightBarButtonItem = button
	}

	@objc private func reset() {
		FirebaseManager.shered.signOut { (result: Result<Void, Error>) in
			switch result {
			case .success(_):
				UserDefaults.standard.removeObject(forKey: Constants().userKey)
				let vc = InViewController()
				vc.modalPresentationStyle = .fullScreen
				self.present(vc, animated: true)
			case .failure(let failure):
				self.alertUserLoginError(string: failure.localizedDescription)
			}
		}
	}

	private func alertUserLoginError(string message: String) {
		let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
		present(alert, animated: true)
	}
}
