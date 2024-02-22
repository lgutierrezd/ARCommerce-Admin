//
//  Product.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 28/12/23.
//

import SwiftUI

struct Product: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let name: String
    let slug: String
    let isActive: Bool
    let categories: [String]
    let brand: String
    let suppliers: Array<String>
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


class ProductConfig: Identifiable {
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

struct Config: Codable {
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
    let stock: [String]
    let config: [String]?
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
