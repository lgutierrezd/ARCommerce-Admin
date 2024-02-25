//
//  Product.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 28/12/23.
//

import SwiftUI

struct Product: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var name: String
    var slug: String
    var isActive: Bool
    var categories: [String]
    var brand: String
    var suppliers: [String]
}

class ProductV1: Codable {
    let _id: String
    var brand: Brand
    var categories: [Category]
    let id: String
    var isActive: Bool
    var name: String
    var reviews: [Review]
    var slug: String
    var suppliers: [String]
    
    init(_id: String, brand: Brand = Brand(id: "", name: ""), categories: [Category] = [], id: String, isActive: Bool, name: String, reviews: [Review] = [], slug: String, suppliers: [String] = []) {
        self._id = _id
        self.brand = brand
        self.categories = categories
        self.id = id
        self.isActive = isActive
        self.name = name
        self.reviews = reviews
        self.slug = slug
        self.suppliers = suppliers
    }
}

class ProductDetail: Identifiable {
    var id: String
    var configs: [ProductConfig]
    
    init(id: String, configs: [ProductConfig]) {
        self.id = id
        self.configs = configs
    }
}




struct ProductConfig: Identifiable {
    var id: String
    var price: Double
    var priceText: String
    var discountPrice: Double
    var discountPriceText: String
    var productionPrice: Double
    var productionPriceText: String
    var type: String
    var selectedColor: Color = .blue
    var colorHex: String
    var size: String
    var weight: String
    var images: [String]
    var uimages: [UIImage]?
    var productDescription: String
    var stock: [Stock]
    var isActive: Bool
    var extraConfig: Dictionary<String, String>?
    
    init(id: String, price: Double, discountPrice: Double, productionPrice: Double, type: String, selectedColor: Color, colorHex: String, size: String, weight: String, images: [String], uimages: [UIImage]? = [], productDescription: String, stock: [Stock] = [], isActive: Bool, extraConfig: Dictionary<String, String> = [:]) {
        self.id = id
        self.price = price
        self.discountPrice = discountPrice
        self.discountPriceText = String(discountPrice)
        self.productionPrice = productionPrice
        self.selectedColor = selectedColor
        self.colorHex = colorHex
        self.images = images
        self.uimages = uimages
        self.productDescription = productDescription
        self.stock = stock
        self.isActive = isActive
        self.extraConfig = extraConfig
        self.priceText = String(price)
        self.productionPriceText = String(productionPrice)
        self.type = type
        self.size = size
        self.weight = weight
    }
}


struct ProductConfigResult: Codable {
    let __v: Int
    let _id: String
    let configs: [Config]
}

class Config: Codable {
    let _id: String
    let colorHex: String
    let size: String
    let weight: String
    let images: [String]
    let isActive: Bool
    let price: Double
    let discountPrice: Double
    let productDescription: String
    let type: String
    let productionPrice: Double
    let stock: [StockV1]
    let config: [String]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.colorHex = try container.decode(String.self, forKey: .colorHex)
        self.size = try container.decode(String.self, forKey: .size)
        self.weight = try container.decode(String.self, forKey: .weight)
        self.images = try container.decode([String].self, forKey: .images)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.price = try container.decode(Double.self, forKey: .price)
        self.discountPrice = try container.decode(Double?.self, forKey: .discountPrice) ?? 0
        self.productDescription = try container.decode(String.self, forKey: .productDescription)
        self.type = try container.decode(String.self, forKey: .type)
        self.productionPrice = try container.decode(Double.self, forKey: .productionPrice)
        self.stock = try container.decode([StockV1].self, forKey: .stock)
        self.config = try container.decodeIfPresent([String].self, forKey: .config)
    }
}

extension Color {
    init(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            Scanner(string: hexSanitized).scanHexInt64(&rgb)

            self.init(
                red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                blue: Double(rgb & 0x0000FF) / 255.0
            )
        }
}
