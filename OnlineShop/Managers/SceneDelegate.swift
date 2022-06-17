//
//  SceneDelegate.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else {
			return
		}
		window = UIWindow(frame: UIScreen.main.bounds)

		if Auth.auth().currentUser == nil {
			startWithoutAuthorization()
			window?.windowScene = windowScene
		} else {
			startAuthorized()
			window?.windowScene = windowScene
		}
	}

	func startAuthorized() {
		let startVC = MainTabBarController()
		window?.rootViewController = startVC
		window?.makeKeyAndVisible()
	}

	func startWithoutAuthorization() {
		let startVC = InViewController()
		window?.rootViewController = startVC
		window?.makeKeyAndVisible()
	}
}
