//
//  Order.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import Foundation

struct Order: Decodable {
    let totalValue: Double
    let productList: [ItemOrder]
}

struct ItemOrder: Decodable {
    let productID: String
    let productType: String
    let date: String
    let name: String
    let price: Double
    let quantity: Int
}
