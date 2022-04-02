//
//  FavoriteViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 1.04.22.
//

import UIKit

class FavoriteViewController: UIViewController {
static var sourceArray = [ProductInCart]()
	private lazy var productsTableView: UITableView = {
	  let table = UITableView()
	  table.register(CartCell.self, forCellReuseIdentifier: CartCell.cellIdentifier)
	  table.translatesAutoresizingMaskIntoConstraints = false
	  return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
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
		productsTableView.reloadData()
	}
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	  return FavoriteViewController.sourceArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	if let cell = productsTableView.dequeueReusableCell(withIdentifier: CartCell.cellIdentifier, for: indexPath)
		as? CartCell {
		if !FavoriteViewController.sourceArray.isEmpty {
			cell.config(model: FavoriteViewController.sourceArray[indexPath.row])}
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

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	  if editingStyle == .delete {
		  FavoriteViewController.sourceArray.remove(at: indexPath.row)
		  tableView.deleteRows(at: [indexPath], with: .left)
	  }
	}

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	tableView.deselectRow(at: indexPath, animated: true)
//	let model = ContactsModel.contactsSourceArray.contacts[indexPath.row]
//	guard let image =  model.image.getImage() else {
//	  return
//	}
//	let viewController = InfoAboutContactViewController(
//	  imageItem: image,
//	  titleItem: model.name,
//	  item: model,
//	  indexPath: indexPath)
//	navigationController?.pushViewController(viewController, animated: true)
  }
}
