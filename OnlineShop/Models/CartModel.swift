//
//  CartModel.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 1.04.22.
//

import Foundation

struct CartModel: Codable {
	let id, userID: Int
	let date: String
	let products: [ProductInCart]
	let v: Int

	enum CodingKeys: String, CodingKey {
		case id
		case userID = "userId"
		case date, products
		case v = "__v"
	}
}

// MARK: - Product
struct ProductInCart: Codable {
	let productID, quantity: Int

	enum CodingKeys: String, CodingKey {
		case productID = "productId"
		case quantity
	}
}
