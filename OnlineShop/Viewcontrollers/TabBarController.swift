//
//  ViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class MainTabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		tabBar.tintColor = Constants().greenColor
		setupVCs()
	}

	private func setupVCs() {

		let homeFillImage = UIImage(systemName: "house.fill")
		guard let homeFillImage = homeFillImage else {
			return
		}

		let discountFillImage = UIImage(systemName: "percent")
		guard let discountFillImage = discountFillImage else {
			return
		}

		let cartFillImage = UIImage(systemName: "cart.fill")
		guard let cartFillImage = cartFillImage else {
			return
		}

		let heartFillImage = UIImage(systemName: "heart.fill")
		guard let heartFillImage = heartFillImage else {
			return
		}

		let personFillImage = UIImage(systemName: "person.fill")
		guard let personFillImage = personFillImage else {
			return
		}

		viewControllers = [
			createNavController(for: CategoriesViewController(),
								   title: NSLocalizedString("Home", comment: ""),
								   image: homeFillImage),
			createNavController(for: CatalogViewController(),
								   title: NSLocalizedString("Discount", comment: ""),
								   image: discountFillImage),
			createNavController(for: ShopCartViewController(),
								   title: NSLocalizedString("Cart", comment: ""),
								   image: cartFillImage),
			createNavController(for: FavoriteViewController(),
								   title: NSLocalizedString("Saved", comment: ""),
								   image: heartFillImage),
			createNavController(for: ProfileViewController(),
								   title: NSLocalizedString("Profile", comment: ""),
								   image: personFillImage),
		]
	}

	private func createNavController(for rootViewController: UIViewController,
									 title: String,
									 image: UIImage) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		//	navController.navigationBar.prefersLargeTitles = true
		rootViewController.navigationItem.title = title
		return navController
	}
}
