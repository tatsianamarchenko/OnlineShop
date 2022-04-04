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

	var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()

	var scrollView : UIScrollView = {
		var scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.backgroundColor = .systemGreen
		return scrollView
	}()

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
		view.addSubview(search)
		view.addSubview(scrollView)
		scrollView.addSubview(mainCollection)
		scrollView.addSubview(categotisStackView)
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
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: search.bottomAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])


		NSLayoutConstraint.activate([
			mainCollection.topAnchor.constraint(equalTo: categotisStackView.topAnchor, constant: 100),
			mainCollection.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -150),
			mainCollection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			mainCollection.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
		])

		NSLayoutConstraint.activate([
			categotisStackView.topAnchor.constraint(equalTo: search.bottomAnchor),
			categotisStackView.heightAnchor.constraint(equalToConstant: 100),
			categotisStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			categotisStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
	  cell.photoOfProduct.layer.cornerRadius = 10
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
	return CGSize(width: 200, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
	return 1
  }
  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
	return 20
  }

  func collectionView(_ collectionView: UICollectionView,
					  layout collectionViewLayout: UICollectionViewLayout,
					  insetForSectionAt section: Int) -> UIEdgeInsets {
	return UIEdgeInsets(top: 110, left: 10, bottom: 130, right: 10)
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
