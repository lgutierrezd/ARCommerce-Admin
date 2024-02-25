//
//  Stock.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 22/2/24.
//

import Foundation

class StockV1: Codable {
    var _id: String
    var location: String
    var quantity: Int
    var size: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.location = try container.decode(String.self, forKey: .location)
        self.quantity = try container.decode(Int?.self, forKey: .quantity) ?? 0
        self.size = try container.decode(String?.self, forKey: .size) ?? ""
    }
}


class Stock: Codable, Hashable {
    var location: Location
    var quantity: Int
    var quantityText: String = ""
    var size: String
    
    init(location: Location, quantity: Int, size: String) {
        self.location = location
        self.quantity = quantity
        self.size = size
    }
    
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        return lhs.location == rhs.location && lhs.quantity == rhs.quantity && lhs.size == rhs.size
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location)
        hasher.combine(quantity)
        hasher.combine(size)
    }
}
