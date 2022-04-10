//
//  ProductsModel.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import Foundation
import UIKit

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

