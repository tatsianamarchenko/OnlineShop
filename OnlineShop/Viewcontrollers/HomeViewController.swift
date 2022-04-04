//
//  CategoriesViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import Alamofire

class CategoriesViewController: UIViewController {
	static var contentArray = [Product]()

	var animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)

	var search: UISearchBar = {
		var search = UISearchBar()
		search.placeholder = "Find your plant"
		search.translatesAutoresizingMaskIntoConstraints = false
		return search
	}()
	
	private lazy var table : UITableView = {
		let table = UITableView()
		table.register(Cell.self, forCellReuseIdentifier: Cell.cellIdentifier)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.backgroundColor = .systemMint
		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(search)
		view.addSubview(table)
		table.dataSource = self
		table.delegate = self
		loadInfo()
		makeConstraints()
	}

	func loadInfo() {
		AF.request("https://fakestoreapi.com/products")
			.validate()
			.responseDecodable(of: [Product].self) { (response) in
				guard let products = response.value else { return }
				CategoriesViewController.contentArray = products
				self.table.reloadData()
			}
	}

	func makeConstraints() {
		NSLayoutConstraint.activate([
			search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			search.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			table.topAnchor.constraint(equalTo: search.bottomAnchor),
			table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		3
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		"lol"
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = table.dequeueReusableCell(withIdentifier: Cell.cellIdentifier, for: indexPath) as? Cell else {
			return UITableViewCell()
		}
		cell.config()
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 300
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
