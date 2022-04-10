//
//  SceneDelegate.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
	  guard let windowScene = (scene as? UIWindowScene) else {
		return
	  }
	  window = UIWindow(frame: UIScreen.main.bounds)

		if let name = UserDefaults.standard.string(forKey: "user") {
			print(name)
			let home = MainTabBarController()
			self.window?.rootViewController = home
		} else {
			let home = InViewController()
			self.window?.rootViewController = home
		}
		window?.makeKeyAndVisible()
		window?.windowScene = windowScene
	}
}

