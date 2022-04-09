//
//  TrendingViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class CatalogViewController: UIViewController {

	var filtered = [Flower]()
	var searchActive : Bool = false
	var flowers = [Flower]()
	var firebaseManager = FirebaseManager()
	var sort: String?

	var scView: UIScrollView = {
		var scView = UIScrollView(frame:.zero)
		scView.translatesAutoresizingMaskIntoConstraints = false
		scView.showsVerticalScrollIndicator = false
		scView.showsHorizontalScrollIndicator = false
		return scView
	}()

	var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()

	var sourceArray = [ProductInCart]()
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
		view.addSubview(itemsCollection)
		view.addSubview(search)
		view.addSubview(scView)
		itemsCollection.dataSource = self
		itemsCollection.delegate = self
		search.delegate = self
		createSortingButtons()
		makeConstants()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
		loadInfo(sort: sort)
	}

	func loadInfo(sort: String?) {
		flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			if self.sort == nil {
				self.flowers.append(flower)
				self.itemsCollection.reloadData()
			}
			else {
				switch sort {
				case "Living room":
					if flower.type == "Living room" {
						self.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
				case "Bathroom":
					if flower.type == "Bathroom" {
						self.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
				case "Bedroom":
					if flower.type == "Bedroom" {
						self.flowers.append(flower)
					}
					self.itemsCollection.reloadData()
				case "Kitchen":
					if flower.type == "Kitchen" {
						self.flowers.append(flower)
						self.itemsCollection.reloadData()
					}
				default: 	break
				}
			}
		}
	}

	func createSortingButtons() {
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

	@objc func btnTouch(_ button: UIButton) {
		self.flowers.removeAll()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			switch button.accessibilityIdentifier {
			case "All":
				self.flowers.append(flower)
				self.itemsCollection.reloadData()
			case "Living room":
				if flower.type == "Living room" {
					self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Bathroom":
				if flower.type == "Bathroom" {
					self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Bedroom":
				if flower.type == "Bedroom" {
					self.flowers.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Kitchen":
				if flower.type == "Kitchen" {
					self.flowers.append(flower)
					self.itemsCollection.reloadData()
				}
			default: 	break
			}
		}
	}

	func filterProposeItems(filter: String) -> [Flower] {
		var filterArray = [Flower]()
		firebaseManager.fetchMain(document: "Flowers") { flower in
			switch filter {
			case "Living room":
				if flower.type == "Living room" {
					filterArray.append(flower)
				}
				self.itemsCollection.reloadData()
			case "Bathroom":
				if flower.type == "Bathroom" {
					filterArray.append(flower)
				}
			case "Bedroom":
				if flower.type == "Bedroom" {
					self.flowers.append(flower)
				}
			case "Kitchen":
				if flower.type == "Kitchen" {
					filterArray.append(flower)
				}
			default: 	break
			}
		}
		return filterArray
	}

	func makeConstants() {

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
			return flowers.count
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
		if !flowers.isEmpty {
			if searchActive {
				cell.photoOfProduct.layer.cornerRadius = 10
				cell.photoOfProduct.image = filtered[indexPath.row].image?.getImage()
				cell.config(madel: filtered[indexPath.row])
			}
			else
			{
				cell.photoOfProduct.layer.cornerRadius = 10
				cell.photoOfProduct.image = flowers[indexPath.row].image?.getImage()
				cell.config(madel: flowers[indexPath.row])

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
		let flower = self.flowers[indexPath.row]
		flowers.removeAll {
			$0.type != flower.type
		}
		let vc = SingleItemViewController(flower: flower, flowerArray: flowers)
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
			filtered = flowers
			itemsCollection.reloadData()
		} else {
			filtered = flowers.filter({ (item) -> Bool in
				return (item.title.localizedCaseInsensitiveContains(String(searchBar.text!)))
			})
			itemsCollection.reloadData()
		}
	}
}
struct Flower: Codable {
	var description: String
	var image: Image?
	var price: String
	var title: String
	var type: String
	var sun: String
	var water: String
	var temperature: String
	var id: String
}

struct Image: Codable {
  let imageData: Data?
  init(withImage image: Data) {
	self.imageData = image
  }
  func getImage() -> UIImage? {
	guard let imageData = self.imageData else {
	  return nil
	}
	let image = UIImage(data: imageData)
	return image
  }
}
