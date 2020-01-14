//
//  CountryModel.swift
//  CountryList-CollectionView
//
//  Created by Brendon Cecilio on 1/14/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
    let currencies: [Currency]
    let flag: String
}

struct Currency: Codable {
    let code, name, symbol: String
}


