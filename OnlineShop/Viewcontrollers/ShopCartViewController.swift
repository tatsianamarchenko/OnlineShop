//
//  ShopCartViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire

class ShopCartViewController: UIViewController {
	var sourceArray = [ProductInCart]()
	private lazy var productsTableView: UITableView = {
	  let table = UITableView()
	  table.register(CartCell.self, forCellReuseIdentifier: CartCell.cellIdentifier)
	  table.translatesAutoresizingMaskIntoConstraints = false
	  return table
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		loadInfo()
		view.addSubview(productsTableView)
		productsTableView.dataSource = self
		productsTableView.delegate = self
		NSLayoutConstraint.activate([
			productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
			productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			productsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}

	func loadInfo() {
		AF.request("https://fakestoreapi.com/carts")
		  .validate()
		  .responseDecodable(of: [CartModel].self) { (response) in
			  guard let productsInCart = response.value else { return }
			  self.sourceArray = productsInCart[0].products
			  self.productsTableView.reloadData()
		  }
	}
}

extension ShopCartViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	  return sourceArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	if let cell = productsTableView.dequeueReusableCell(withIdentifier: CartCell.cellIdentifier, for: indexPath)
		as? CartCell {
		if !sourceArray.isEmpty {
			cell.config(model: sourceArray[indexPath.row])}
	  return cell
	}
	return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	return 130
  }

	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		.delete
	}

	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

		let filterAction = UIContextualAction(style: .normal, title: "") { (action, view, bool) in
			print("Swiped to filter")
			FavoriteViewController.sourceArray.append(self.sourceArray[indexPath.row])
			self.sourceArray.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .right)

		}
		filterAction.backgroundColor = .systemGreen
		filterAction.image = UIImage(systemName: "heart")
		filterAction.accessibilityNavigationStyle = .automatic
		return UISwipeActionsConfiguration(actions: [filterAction])
	}


	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	  if editingStyle == .delete {
		sourceArray.remove(at: indexPath.row)
		  tableView.deleteRows(at: [indexPath], with: .left)
	  }
	}

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	tableView.deselectRow(at: indexPath, animated: true)
//	let model = ContactsModel.contactsSourceArray.contacts[indexPath.row]
//	guard let image =  model.image.getImage() else {
//	  return
//	}
	let viewController = SingleItemViewController()
	navigationController?.pushViewController(viewController, animated: true)
  }
}
