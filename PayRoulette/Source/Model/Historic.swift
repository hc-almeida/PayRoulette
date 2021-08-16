//
//  List.swift
//  PayRoulette
//
//  Created by Hellen on 15/08/21.
//

import Foundation

struct Historic: Decodable {
    let totalValue: Double
    let historyAccountList: [HistoricList]
}

struct HistoricList: Decodable {
    let historyID: String
    let date: String
    let name: String
    let price: Double
    let iconImage: String
}
