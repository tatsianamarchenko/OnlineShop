//
//  ProductsModel.swift
//  OnlineShop
//
//  Created by Tatsiana Marchanka on 30.03.22.
//

import Foundation

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
