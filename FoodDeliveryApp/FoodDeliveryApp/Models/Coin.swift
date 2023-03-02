//
//  Coin.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/26/23.
//

import SwiftUI

struct Coin: Identifiable, Decodable {
    var id: Int
    var coin_name: String
    var acronym: String
    var logo: String
}
