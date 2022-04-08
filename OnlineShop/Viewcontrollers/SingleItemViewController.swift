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
		button.backgroundColor = Constants().greenColor
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		return button
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

		stepper.tintColor = Constants().greyColor
		stepper.translatesAutoresizingMaskIntoConstraints = false
		stepper.stepValue = 1
		return stepper
	}()

	func createBacicInformationImage (string: String) -> UIImageView {
		let image = UIImageView(image: UIImage(systemName: string)?.withTintColor(Constants().greyColor, renderingMode: .alwaysOriginal))
		image.backgroundColor = Constants().whiteColor
			image.layer.cornerRadius = 3
			image.translatesAutoresizingMaskIntoConstraints = false
			image.clipsToBounds = true
			image.contentMode = .center
			return image
	}

	func createBacicInformationLable(string: String) -> UILabel {
		let lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.text = string
		lable.textColor = Constants().greyColor
		lable.contentMode = .center
		return lable
	}

	private lazy  var priceLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "$60"
		title.font = UIFont.systemFont(ofSize: 30)
		title.textColor = Constants().greenColor
		return title
	}()

	func createIteminfoStack(title: String, info: String) -> UIStackView {
		let titleLable = UILabel()
		titleLable.text = title
		titleLable.textColor = Constants().greyColor
		let infoLable = UILabel()
		infoLable.text = info
		infoLable.textColor = Constants().darkGreyColor
		let stack = UIStackView(arrangedSubviews: [titleLable, infoLable])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .leading
		return stack
	}

	private lazy var descriptionLable : UILabel = {
		var lable = UILabel()
		lable.translatesAutoresizingMaskIntoConstraints = false
		lable.textColor = Constants().darkGreyColor
		lable.text = "Description"
		return lable
	}()

	private lazy var descriptionTextView : ReadMoreTextView = {
		var textView = ReadMoreTextView()
		textView.shouldTrim = true
		textView.maximumNumberOfLines = 3
		textView.readMoreText = " Read more"
		textView.readLessText = " Read less"
		textView.textColor = Constants().greyColor
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = .systemFont(ofSize: 15)
		textView.text = "Lavender plants are small, branching and spreading shrubs with grey-green leaves and long flowering shoots. The leaves can be simple or pinnate measuring 30–50 mm (1–2 in) in length. The plant produces flowers on shoots or spikes which can be 20–40 cm (8–16 in) long. The flowers are lilac or blue in color."
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
		collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.backgroundColor = .systemPink
		collection.clipsToBounds = true
		return collection
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(productImageView)
		let hudrationImage = createBacicInformationImage(string: "drop")
		let sunImage = createBacicInformationImage(string: "sun.min")
		let temperatureImage = createBacicInformationImage(string: "thermometer")

		let hudrationLable =	createBacicInformationLable(string: "3-3.5L")
		let sunLable = createBacicInformationLable(string: "18-20H")
		let temperatureLable = createBacicInformationLable(string: "7-21 C")

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
	}

	func createBar() {
		title = "lavanda"
		tabBarController?.tabBar.isHidden = true
		let saveImage = UIImage(systemName: "heart")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
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
		let unfavImage = UIImage(systemName: "heart")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
		guard let unfavImage = unfavImage else {
			return
		}
		let favImage = UIImage(systemName: "heart.fill")?.withTintColor(Constants().greenColor, renderingMode: .alwaysOriginal)
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

extension UIView {

	static func spacer(size: CGFloat = 3, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
		let spacer = UIView()

		if layout == .horizontal {
			spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
		} else {
			spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
		}

		return spacer
	}

}

extension SingleItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
	1
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
	return 1
  }



  func collectionView(_ collectionView: UICollectionView,
					  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	  guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
															ItemCollectionViewCell.identifier, for: indexPath)
				as? ItemCollectionViewCell else {
					return UICollectionViewCell()
				}
	  cell.placeLabel.text = "shbd"
	  cell.photoOfProduct.layer.cornerRadius = 10
	//  cell.photoOfProduct.downloadedFrom(url: CategoriesViewController.contentArray[indexPath.row].image)
	  cell.clipsToBounds = true
	  cell.layer.shadowRadius = 10
	  cell.layer.shadowColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
	  return cell
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  sizeForItemAt indexPath: IndexPath) -> CGSize {
	return CGSize(width: 200, height: 100)
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
