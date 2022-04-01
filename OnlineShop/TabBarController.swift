//
//  ViewController.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class MainTabBarController: UITabBarController {

  private lazy var animation: CAKeyframeAnimation = {
	let animation = CAKeyframeAnimation(keyPath: "transform.scale")
	animation.values = [1.0, 1.1, 0.9, 1.02, 1.0]
	animation.duration = TimeInterval(0.3)
	animation.calculationMode = CAAnimationCalculationMode.cubic
	return animation
  }()

  override func viewDidLoad() {
	super.viewDidLoad()
	view.backgroundColor = .systemBackground
	  tabBar.tintColor = .systemMint
	setupVCs()
  }

	private func setupVCs() {
		let categotyImage = UIImage(systemName: "house")
		guard let categotyImage = categotyImage else {
			return
		}
		let categotyFillImage = UIImage(systemName: "house.fill")
		guard let categotyFillImage = categotyFillImage else {
			return
		}
		let trendingImage = UIImage(systemName: "eye")
		guard let trendingImage = trendingImage else {
			return
		}
		let trendingFillImage = UIImage(systemName: "eye.fill")
		guard let trendingFillImage = trendingFillImage else {
			return
		}
		let cartImage = UIImage(systemName: "cart")
		guard let cartImage = cartImage else {
			return
		}
		let cartFillImage = UIImage(systemName: "cart.fill")
		guard let cartFillImage = cartFillImage else {
			return
		}

		viewControllers = [
			createNavController(for: CategoriesViewController(),
								   title: NSLocalizedString("Categories", comment: ""),
								   image: categotyImage,
								   selectedImage: categotyFillImage),
			createNavController(for: TrendingViewController(),
								   title: NSLocalizedString("Trends", comment: ""),
								   image: trendingImage,
								   selectedImage: trendingFillImage),
			createNavController(for: ShopCartViewController(),
								   title: NSLocalizedString("Cart", comment: ""),
								   image: cartImage,
								   selectedImage: cartFillImage)
		]
	}

  private func createNavController(for rootViewController: UIViewController,
								   title: String,
								   image: UIImage, selectedImage: UIImage) -> UIViewController {
	let navController = UINavigationController(rootViewController: rootViewController)
	navController.tabBarItem.title = title
	navController.tabBarItem.selectedImage = selectedImage
	navController.tabBarItem.image = image
	navController.navigationBar.prefersLargeTitles = true
	  rootViewController.navigationItem.title = title
	return navController
  }
}

extension MainTabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
	guard let imageView = item.value(forKey: "view") as? UIView else {
	  return
	}
	imageView.layer.add(animation, forKey: nil)
  }
}
