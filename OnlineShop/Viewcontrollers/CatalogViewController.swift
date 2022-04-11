//
//  TrendingViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import NVActivityIndicatorView
import Firebase

class CatalogViewController: UIViewController {

	static var flowers = [Flower]()

	private var filtered = [Flower]()
	private var searchActive : Bool = false
	private var firebaseManager = FirebaseManager()
	private var sort: String?

	private lazy var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100),
																	 type: .ballZigZag, color: Constants().greenColor, padding: nil)

	private lazy var scView: UIScrollView = {
		var scView = UIScrollView(frame:.zero)
		scView.translatesAutoresizingMaskIntoConstraints = false
		scView.showsVerticalScrollIndicator = false
		scView.showsHorizontalScrollIndicator = false
		return scView
	}()

	private lazy var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	private lazy var itemsCollection : UICollectionView = {
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		layout.scrollDirection = .vertical
		var collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collection.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.showsVerticalScrollIndicator = false
		collection.backgroundColor = .systemBackground
		collection.clipsToBounds = true
		return collection
	}()

	init(sort: String?) {
		self.sort = sort
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addSubview(itemsCollection)
		view.addSubview(search)
		view.addSubview(scView)
		view.addSubview(activityIndicatorView)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		search.delegate = self
		createSortingButtons()
		makeConstants()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		activityIndicatorView.startAnimating()
		tabBarController?.tabBar.isHidden = false
		loadInfo(sort: sort)
	}

	private func loadInfo(sort: String?) {
		CatalogViewController.flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			if self.sort == nil {
				CatalogViewController.flowers.append(flower)
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			}
			else {
				switch sort {
				case "Living room":
					if flower.type == "Living room" {
						CatalogViewController.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
					self.activityIndicatorView.stopAnimating()
				case "Bathroom":
					if flower.type == "Bathroom" {
						CatalogViewController.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
					self.activityIndicatorView.stopAnimating()
				case "Bedroom":
					if flower.type == "Bedroom" {
						CatalogViewController.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
					self.activityIndicatorView.stopAnimating()
				case "Kitchen":
					if flower.type == "Kitchen" {
						CatalogViewController.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
					self.activityIndicatorView.stopAnimating()
				default: 	break
				}
			}
		}
	}

	private func createSortingButtons() {
		let buttonPadding:CGFloat = 10
		var xOffset:CGFloat = 10
		let buttonNameArray = ["All", "Living room", "Bathroom", "Bedroom", "Kitchen"]
		for (_, value) in buttonNameArray.enumerated() {
			let button = UIButton()
			button.accessibilityIdentifier = value
			button.setTitle(value, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 20)
			button.addTarget(self, action: #selector(btnTouch), for: .touchUpInside)
			button.titleLabel?.textAlignment = .center
			button.setTitleColor(Constants().greenColor, for: .normal)
			button.setTitleColor(Constants().darkGreyColor, for: .selected)
			button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
			xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
			scView.addSubview(button)
			scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
		}
	}

	@objc private func btnTouch(_ button: UIButton) {
		activityIndicatorView.startAnimating()
		CatalogViewController.flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			switch button.accessibilityIdentifier {
			case "All":
				CatalogViewController.flowers.append(flower)
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			case "Living room":
				if flower.type == "Living room" {
					CatalogViewController.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			case "Bathroom":
				if flower.type == "Bathroom" {
					CatalogViewController.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			case "Bedroom":
				if flower.type == "Bedroom" {
					CatalogViewController.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			case "Kitchen":
				if flower.type == "Kitchen" {
					CatalogViewController.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
				self.activityIndicatorView.stopAnimating()
			default: 	break
			}
		}
	}

	private func makeConstants() {

		NSLayoutConstraint.activate([
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			scView.topAnchor.constraint(equalTo: search.bottomAnchor),
			scView.bottomAnchor.constraint(equalTo: itemsCollection.topAnchor),
			scView.heightAnchor.constraint(equalToConstant: 50),
			scView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			itemsCollection.topAnchor.constraint(equalTo: scView.bottomAnchor),
			itemsCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			itemsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}

}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if searchActive {
			return filtered.count
		}
		else
		{
			return CatalogViewController.flowers.count
		}
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
		if !CatalogViewController.flowers.isEmpty {
			if searchActive {
				cell.config(madel: filtered[indexPath.row], indexPath: indexPath)
			}
			else
			{
				cell.config(madel: CatalogViewController.flowers[indexPath.row], indexPath: indexPath)

			}
		}
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
		return CGSize(width: view.frame.width-20, height: view.frame.height/5-20)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 30
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let flower = CatalogViewController.flowers[indexPath.row]
		var new = CatalogViewController.flowers
		new.removeAll {
			$0.type != flower.type
		}
		let vc = SingleItemViewController(flower: flower, flowerArray: new)
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension CatalogViewController: UISearchBarDelegate {

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchActive = true
		self.search.showsCancelButton = true
		self.itemsCollection.reloadData()
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.search.text = ""
		self.filtered = []
		searchActive = false
		self.search.showsCancelButton = false
		self.search.endEditing(true)
		self.dismiss(animated: true, completion: nil)
		self.itemsCollection.reloadData()
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		if searchBar.text! == " "  {
			filtered = CatalogViewController.flowers
			itemsCollection.reloadData()
		} else {
			filtered = CatalogViewController.flowers.filter({ (item) -> Bool in
				let text = searchBar.text ?? ""
				return (item.title.localizedCaseInsensitiveContains(text))
			})
			itemsCollection.reloadData()
		}
	}
}
