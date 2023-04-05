//
//  String + Extention.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/7/23.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
