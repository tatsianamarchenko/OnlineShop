//
//  CategoriesViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire

class CategoriesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
	static var contentArray = [Product]()

	var animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)

	var womenSortButton: UIButton = {
		var button = UIButton()
		button.setTitle("womenSortButton", for: .normal)
		button.backgroundColor = .orange
		button.layer.cornerRadius = 10
		return button
	}()

	var menSortButton: UIButton = {
		var button = UIButton()
		button.setTitle("menSortButton", for: .normal)
		button.layer.cornerRadius = 10
		button.backgroundColor = .systemGray
		return button
	}()

	private lazy var  categotisStackView: UIStackView = {
		var stack = UIStackView(arrangedSubviews: [womenSortButton, menSortButton])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.backgroundColor = .systemBlue
		stack.axis = .vertical
		stack.alignment = .center
		return stack
	}()

	private lazy var mainCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .horizontal
	//	layout.estimatedItemSize = .zero
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.backgroundColor = .systemPink
		collection.clipsToBounds = true
		return collection
	}()
	var openProductCardGesture = UITapGestureRecognizer()
	var closeProductCardGesture = UITapGestureRecognizer()
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(mainCollection)
		view.addSubview(categotisStackView)
		openProductCardGesture = UITapGestureRecognizer(target: self, action: #selector(openProduct))
		closeProductCardGesture = UITapGestureRecognizer(target: self, action: #selector(closeProduct))
		closeProductCardGesture.numberOfTapsRequired = 2
		mainCollection.addGestureRecognizer(openProductCardGesture)
		mainCollection.addGestureRecognizer(closeProductCardGesture)
		mainCollection.delegate = self
		mainCollection.dataSource = self
		loadInfo()
		makeConstraints()
	}

	@objc func openProduct() {
		self.animator.startAnimation()
		self.animator.addCompletion {_ in
			print("complieted")
		}
	}

	@objc func closeProduct() {
		animator.addAnimations {
			self.mainCollection.transform = .identity
		}
		self.animator.addCompletion {_ in
			print("lol")
		}
		self.animator.startAnimation()
	}

	func loadInfo() {
		AF.request("https://fakestoreapi.com/products")
		  .validate()
		  .responseDecodable(of: [Product].self) { (response) in
			  guard let products = response.value else { return }
			  CategoriesViewController.contentArray = products
			  self.mainCollection.reloadData()
		  }
	}

	func makeConstraints() {
		NSLayoutConstraint.activate([
			mainCollection.topAnchor.constraint(equalTo: categotisStackView.topAnchor, constant: 100),
			mainCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			mainCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mainCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		NSLayoutConstraint.activate([
			categotisStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			categotisStackView.heightAnchor.constraint(equalToConstant: 200),
			categotisStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			categotisStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
	  return CategoriesViewController.contentArray.count
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
	  cell.photoOfProduct.downloadedFrom(url: CategoriesViewController.contentArray[indexPath.row].image)
	  cell.clipsToBounds = true
	  animator.addAnimations {
		  cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
		  cell.photoOfProduct.layer.cornerRadius = 30
	  }
	  return cell
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  sizeForItemAt indexPath: IndexPath) -> CGSize {
	return CGSize(width: 300, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
	return 10
  }
  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
	return 100
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  insetForSectionAt section: Int) -> UIEdgeInsets {
	return UIEdgeInsets(top: 110, left: 50, bottom: 30, right: 50)
  }
}

extension UIImageView {

	func downloadedFrom(url: String) {
		guard let url = URL(string: url) else { return }
		URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
			guard let data = data, error == nil, let image = UIImage(data: data) else { return }
			DispatchQueue.main.async { () -> Void in
				self.image = image
			}
		}).resume()
	}
}
