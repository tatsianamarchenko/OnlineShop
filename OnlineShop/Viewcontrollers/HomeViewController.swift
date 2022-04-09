//
//  HomeViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class HomeViewController: UIViewController {
	static var flowers = [Flower]()
	var categories = [Category]()
	var firebaseManager = FirebaseManager()
	
	var scrollView : UIScrollView = {
		var scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()


	var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()

	private lazy  var namelLabel: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Categories"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().darkGreyColor
		return title
	}()

	private lazy  var saleLable: UILabel = {
		var title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Sale"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 20)
		title.textColor = Constants().darkGreyColor
		return title
	}()

	private lazy var mainCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .horizontal
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.clipsToBounds = true
		return collection
	}()

	var saleImage: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		image.layer.cornerRadius = 10
		image.clipsToBounds = true
		return image
	}()

	var accessoryImage: UIImageView = {
		var image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		image.layer.cornerRadius = 10
		image.clipsToBounds = true
		return image
	}()

	var saleView  = UIView().createCustomView()
	var accessoriesView  = UIView().createCustomView()

	override func viewDidLoad() {
		super.viewDidLoad()

		firebaseManager.fetchData(document: "Category") { category in
			self.categories.append(category)
			self.mainCollection.reloadData()
		}
		firebaseManager.fetchImage(collection: "Sale", imageView: saleImage)
		firebaseManager.fetchImage(collection: "Accessories", imageView: accessoryImage)
		view.addSubview(scrollView)
		view.addSubview(search)

		scrollView.addSubview(saleView)
		saleView.addSubview(saleImage)
		scrollView.addSubview(mainCollection)
		scrollView.addSubview(namelLabel)
		scrollView.addSubview(saleLable)
		scrollView.addSubview(accessoriesView)
		accessoriesView.addSubview(accessoryImage)
		mainCollection.delegate = self
		mainCollection.dataSource = self
		makeConstraints()
	}
	
	func makeConstraints() {
		NSLayoutConstraint.activate([
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: search.bottomAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		NSLayoutConstraint.activate([
			saleLable.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
			saleLable.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
			saleLable.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 10),
		])


		NSLayoutConstraint.activate([
			saleView.topAnchor.constraint(equalTo: saleLable.bottomAnchor, constant: 10),
			saleView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
			saleView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 10),
			saleView.heightAnchor.constraint(equalToConstant: 200),
			saleView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
		])

		NSLayoutConstraint.activate([
			saleImage.leadingAnchor.constraint(equalTo: saleView.leadingAnchor),
			saleImage.widthAnchor.constraint(equalTo: saleView.widthAnchor),
			saleImage.heightAnchor.constraint(equalTo: saleView.heightAnchor),
			saleImage.topAnchor.constraint(equalTo: saleView.topAnchor),
		])

		NSLayoutConstraint.activate([
			accessoryImage.leadingAnchor.constraint(equalTo: accessoriesView.leadingAnchor),
			accessoryImage.widthAnchor.constraint(equalTo: accessoriesView.widthAnchor),
			accessoryImage.heightAnchor.constraint(equalTo: accessoriesView.heightAnchor),
			accessoryImage.topAnchor.constraint(equalTo: accessoriesView.topAnchor),
		])

		NSLayoutConstraint.activate([
			namelLabel.topAnchor.constraint(equalTo: saleView.bottomAnchor, constant: 10),
			namelLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
			namelLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 10),
		])

		NSLayoutConstraint.activate([
			mainCollection.topAnchor.constraint(equalTo: namelLabel.bottomAnchor, constant: 10),
			mainCollection.bottomAnchor.constraint(equalTo: accessoriesView.topAnchor, constant: -10),
			mainCollection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			mainCollection.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			mainCollection.heightAnchor.constraint(equalToConstant: 330)
		])

		NSLayoutConstraint.activate([
			accessoriesView.topAnchor.constraint(equalTo: mainCollection.bottomAnchor, constant: 10),
			accessoriesView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
			accessoriesView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 10),
			accessoriesView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10),
			accessoriesView.heightAnchor.constraint(equalToConstant: 200),
			accessoriesView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
		])
	}
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.categories.count
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
		if !categories.isEmpty {
			cell.placeLabel.text = categories[indexPath.row].name
			cell.photoOfProduct.image = categories[indexPath.row].image?.getImage()
		}
		cell.photoOfProduct.layer.cornerRadius = 10
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
		return CGSize(width: 200, height: 300)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = CatalogViewController(sort: categories[indexPath.row].name)
			self.navigationController?.pushViewController(vc, animated: true)
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
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}
}

struct Category: Codable {
	var image: Image?
	var name: String
}

extension UIView {
	func createCustomView() -> UIView {
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
	}
}
