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
    let category: String
    let brand: String
    let suppliers: Array<String>
}

class ProductV1: Codable {
    let _id: String
    let brand: Brand
    let category: Category
    let id: String
    var isActive: Bool
    let name: String
    //let reviews: [Review]
    let slug: String
    let suppliers: [String]
}

class ProductDetail: Identifiable {
    var id: String
    var configs: [ProductConfig]
    
    init(id: String, configs: [ProductConfig]) {
        self.id = id
        self.configs = configs
    }
}

class ProductConfig: Identifiable {
    var id: String
    var price: Double
    var priceText: String
    var productionPrice: Double
    var productionPriceText: String
    var selectedColor: Color = .blue
    var colorHex: String
    var images: [String]
    var uimages: [UIImage]?
    var productDescription: String
    var stock: [Stock]?
    var isActive: Bool
    var extraConfig: Dictionary<String, String>?
    class Stock: Codable {
        
        var location: String
        var quantity: Int
        
        init(location: String, quantity: Int) {
            self.location = location
            self.quantity = quantity
        }
    }
    
    init(id: String, price: Double, productionPrice: Double, selectedColor: Color, colorHex: String, images: [String], uimages: [UIImage]? = [], productDescription: String, stock: [Stock]? = [], isActive: Bool, extraConfig: Dictionary<String, String> = [:]) {
        self.id = id
        self.price = price
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
    let images: [String]
    let isActive: Bool
    let price: Double
    let productDescription: String
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
