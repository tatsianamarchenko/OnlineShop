//
//  FilterManager.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 13.04.22.
//

import Foundation

class FilterManager {

	static var fav = [Flower]()

	func favorite() {
		FirebaseDataBaseManager.shered.fetchItems(collection: "users", field: "favorite") { flower in
			FilterManager.fav.append(flower)
		}
	}

	func loadInfo(sort: String?, complition: @escaping () -> Void) {
		self.favorite()
		CatalogViewController.flowers.removeAll()
		FirebaseDataBaseManager.shered.fetchMain(collection: "Flowers") { flower in
			if sort == nil {
				CatalogViewController.flowers.append(flower)
				complition()
			}
			else {
				switch sort {
				case "All":
					CatalogViewController.flowers.append(flower)
					complition()
				case "Living room":
					if flower.type == "Living room" {
						CatalogViewController.flowers.append(flower)
					}
					complition()
				case "Bathroom":
					if flower.type == "Bathroom" {
						CatalogViewController.flowers.append(flower)
					}
					complition()
				case "Bedroom":
					if flower.type == "Bedroom" {
						CatalogViewController.flowers.append(flower)
					}
					complition()
				case "Kitchen":
					if flower.type == "Kitchen" {
						CatalogViewController.flowers.append(flower)
					}
					complition()
				default: 	break
				}
			}
		}
	}

	func presentVCWithFiler(index: IndexPath, complition: @escaping (SingleItemViewController) -> Void) {
		let flower = CatalogViewController.flowers[index.row]
		var new = CatalogViewController.flowers
		new.removeAll {
			$0.type != flower.type
		}
		let vc = SingleItemViewController(flower: flower, flowerArray: new)
		complition(vc)
	}
}
