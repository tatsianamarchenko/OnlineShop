//
//  Image.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 13.04.22.
//

import Foundation
import UIKit

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
