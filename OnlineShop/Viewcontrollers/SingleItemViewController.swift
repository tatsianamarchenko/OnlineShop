//
//  SingleItemViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import GMStepper
import ReadMoreTextView

class SingleItemViewController: UIViewController {
	private var fav = false
	private var flower: Flower?
	private var flowerArray: [Flower]?

	private lazy var productImageView: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.backgroundColor = .systemGray3
		image.image = flower?.image?.getImage()
		image.contentMode = .scaleToFill
		return image
	}()

	private lazy var flowerView: UIView = {
		var view = UIView()
		return view
	}()

	private var addToCartButton = UIButton().createCustomButton(title: "add to cart")

	private lazy var stepper: GMStepper = {
		var stepper = GMStepper()
		stepper.maximumValue = 100
		stepper.minimumValue = 1
		stepper.buttonsTextColor = Constants.shered.greyColor

		stepper.buttonsBackgroundColor = Constants.shered.whiteColor
		stepper.limitHitAnimationColor = Constants.shered.greyColor
		stepper.labelBackgroundColor = .systemBackground
		stepper.labelTextColor = Constants.shered.greyColor

		stepper.tintColor = Constants.shered.greyColor
		stepper.translatesAutoresizingMaskIntoConstraints = false
		stepper.stepValue = 1
		return stepper
	}()

	private lazy  var priceLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = flower?.price
		title.font = UIFont.systemFont(ofSize: 30)
		title.textColor = Constants.shered.greenColor
		return title
	}()

	private lazy var descriptionLable : UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textColor = Constants.shered.darkGreyColor
		lable.text = "Description"
		return lable
	}()

	private lazy var descriptionTextView : ReadMoreTextView = {
		var textView = ReadMoreTextView()
		textView.shouldTrim = true
		textView.maximumNumberOfLines = 3
		textView.readMoreText = " Read more"
		textView.readLessText = " Read less"
		textView.textColor = Constants.shered.greyColor
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 15)
		textView.text =  flower?.description
		return textView
	}()

	private lazy var similarLable : UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = "Also suitable"
		return lable
	}()

	private lazy var similarCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .horizontal
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.clipsToBounds = true
		return collection
	}()

	init(flower: Flower?, flowerArray: [Flower]?) {
		self.flower = flower
		self.flowerArray = flowerArray
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(productImageView)
		let hudrationImage = createBacicInformationImage(string: "drop")
		let sunImage = createBacicInformationImage(string: "sun.min")
		let temperatureImage = createBacicInformationImage(string: "thermometer")

		let hudrationLable =	createBacicInformationLable(string: flower?.water ?? "?")
		let sunLable = createBacicInformationLable(string: flower?.sun ?? "?" + "H")
		let temperatureLable = createBacicInformationLable(string: flower?.temperature ?? "?" + "??C")

		let typeStack = createIteminfoStack(title: "Type", info: "Indoor")
		let sizeStack = createIteminfoStack(title: "Size", info: "Medium")
		let levelStack = createIteminfoStack(title: "Level", info: "Hard")

		let mainStack = UIStackView(arrangedSubviews: [typeStack, sizeStack, levelStack, priceLabel])
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		mainStack.axis = .horizontal
		mainStack.distribution = .equalSpacing
		mainStack.alignment = .center
		view.addSubview(mainStack)
		view.addSubview(hudrationImage)
		view.addSubview(sunImage)
		view.addSubview(temperatureImage)
		view.addSubview(hudrationLable)
		view.addSubview(sunLable)
		view.addSubview(temperatureLable)
		view.addSubview(addToCartButton)
		view.addSubview(stepper)
		view.addSubview(descriptionLable)
		view.addSubview(descriptionTextView)
		view.addSubview(similarLable)
		view.addSubview(similarCollection)
		view.backgroundColor = .systemBackground
		createBar()
		similarCollection.delegate = self
		similarCollection.dataSource = self

		NSLayoutConstraint.activate([
			
			productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			productImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2),
			productImageView.heightAnchor.constraint(equalToConstant: view.frame.height/2-40),

			mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			mainStack.topAnchor.constraint(equalTo: productImageView.bottomAnchor),


			descriptionLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			descriptionLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			descriptionLable.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 10),

			descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			descriptionTextView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor),
			descriptionTextView.heightAnchor.constraint(equalToConstant: 70),

			similarLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			similarLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			similarLable.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),

			similarCollection.topAnchor.constraint(equalTo: similarLable.bottomAnchor),
			similarCollection.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -10),
			similarCollection.widthAnchor.constraint(equalTo: view.widthAnchor),

			hudrationImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: 80),
			hudrationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			hudrationImage.widthAnchor.constraint(equalToConstant: 50),
			hudrationImage.heightAnchor.constraint(equalToConstant: 50),
			hudrationLable.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: 80),
			hudrationLable.leadingAnchor.constraint(equalTo: hudrationImage.trailingAnchor, constant: 20),

			sunImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
			sunImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			sunImage.widthAnchor.constraint(equalToConstant: 50),
			sunImage.heightAnchor.constraint(equalToConstant: 50),

			sunLable.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
			sunLable.leadingAnchor.constraint(equalTo: sunImage.trailingAnchor, constant: 20),

			temperatureImage.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: -80),
			temperatureImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			temperatureImage.widthAnchor.constraint(equalToConstant: 50),
			temperatureImage.heightAnchor.constraint(equalToConstant: 50),

			temperatureLable.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor, constant: -80),
			temperatureLable.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 20),

			addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			addToCartButton.heightAnchor.constraint(equalToConstant: 50),
			addToCartButton.widthAnchor.constraint(equalToConstant: view.frame.width/2),
			addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			stepper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			stepper.heightAnchor.constraint(equalToConstant: 50),
			stepper.widthAnchor.constraint(equalToConstant: view.frame.width/3),
			stepper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
		])
		addToCartButton.addTarget(self, action: #selector(toCart), for: .touchUpInside)
	}

	@objc private func toCart() {
		guard let flower = self.flower else {
			return
		}

		FirebaseDataBaseManager.shered.addToDatabase(flower: flower, field: .cart) { (result: Result<Void, Error>) in
			switch result {
			case .success():
				self.createAlert(string: "Added to cart")
			case .failure(let error):
				self.createAlert(string: error.localizedDescription)
			}
		}
	}
	
	private func createAlert(string: String) {
		let alert = UIAlertController(title: "Added", message: string, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
		present(alert, animated: true)
	}

	private func createIteminfoStack(title: String, info: String) -> UIStackView {
		let titleLable = UILabel()
		titleLable.text = title
		titleLable.textColor = Constants.shered.greyColor
		let infoLable = UILabel()
		infoLable.text = info
		infoLable.textColor = Constants.shered.darkGreyColor
		let stack = UIStackView(arrangedSubviews: [titleLable, infoLable])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .leading
		return stack
	}

	private func createBacicInformationImage (string: String) -> UIImageView {
		let image = UIImageView(image: UIImage(systemName: string)?.withTintColor(Constants.shered.greyColor, renderingMode: .alwaysOriginal))
		image.backgroundColor = Constants.shered.whiteColor
		image.layer.cornerRadius = 3
		image.translatesAutoresizingMaskIntoConstraints = false
		image.clipsToBounds = true
		image.contentMode = .center
		return image
	}

	private func createBacicInformationLable(string: String) -> UILabel {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = string
		lable.textColor = Constants.shered.greyColor
		lable.contentMode = .center
		return lable
	}

	private func createBar() {
		title = flower?.title
		tabBarController?.tabBar.isHidden = true
		let saveImage = UIImage(systemName: "heart")?.withTintColor(Constants.shered.greenColor, renderingMode: .alwaysOriginal)
		guard let saveImage = saveImage else {
			return
		}
		let button = UIBarButtonItem(image: saveImage,
									 style: .plain,
									 target: self,
									 action: #selector(addToFavorte))

		navigationItem.rightBarButtonItem = button
	}

	@objc private func addToFavorte(_ sender: UIBarButtonItem) {
		fav.toggle()
		let unfavImage = UIImage(systemName: "heart")?.withTintColor(Constants.shered.greenColor, renderingMode: .alwaysOriginal)
		guard let unfavImage = unfavImage else {
			return
		}
		let favImage = UIImage(systemName: "heart.fill")?.withTintColor(Constants.shered.greenColor, renderingMode: .alwaysOriginal)
		guard let favImage = favImage else {
			return
		}
		if fav == true {
			sender.image = favImage
			guard let flower = self.flower else {
				return
			}

			FirebaseDataBaseManager.shered.addToDatabase(flower: flower, field: .favorite) { (result: Result<Void, Error>) in
				switch result {
				case .success():
					self.createAlert(string: "Added to favorite")
				case .failure(let error):
					self.createAlert(string: error.localizedDescription)
				}
			}

		} else {
			sender.image = unfavImage
		}
	}
}

extension SingleItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		flowerArray?.count ?? 0
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
																ShopCollectionViewCell.identifier, for: indexPath)
				as? ShopCollectionViewCell else {
					return UICollectionViewCell()
				}
		cell.config(madel: (flowerArray?[indexPath.row])!, indexPath: indexPath)
		cell.layer.cornerRadius = 20
		cell.layer.borderWidth = 0
		cell.layer.shadowColor = UIColor.systemGray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0, height: 0)
		cell.layer.shadowRadius = 8
		cell.layer.shadowOpacity = 0.5
		cell.layer.masksToBounds = false
		return cell
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width/1.5, height: 100)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
	}
}
