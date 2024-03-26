//
//  Product.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 28/12/23.
//

import SwiftUI

struct ProductsResponse: Codable {
    let status: String
    let result: Int
    let data: Data
    
    struct Data: Codable {
        let data: [Product]
    }
}

struct ProductResponse: Codable {
    let status: String
    let result: Int
    let data: Data
    
    struct Data: Codable {
        let data: Product
    }
}

struct Product: Codable {
    let _id: String
    var brand: Brand?
    var categories: [Category]
    let id: String
    var isActive: Bool
    var name: String
    var reviews: [Review]
    var slug: String
    var suppliers: [String]
    
    init(_id: String, brand: Brand? = nil, categories: [Category] = [], id: String, isActive: Bool, name: String, reviews: [Review] = [], slug: String, suppliers: [String] = []) {
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

struct ProductDetailResponse: Codable {
    let status: String
    let data: Data
    
    struct Data: Codable {
        let data: ProductDetail
    }
}

struct ProductDetail: Codable {
    var _id: String
    var product: String
    var configs: [Config]
    
    init(_id: String, product: String, configs: [Config]) {
        self._id = _id
        self.product = product
        self.configs = configs
    }
}

struct DetailProductResponse: Codable {
    let status: String
    let data: Data
    
    struct Data: Codable {
        let data: DetailProduct
    }
}

struct DetailProduct: Codable {
    var _id: String
    var product: Product
    var configs: [Config]
    
    init(_id: String, product: Product, configs: [Config]) {
        self._id = _id
        self.product = product
        self.configs = configs
    }
    
    struct Product: Codable {
        let _id: String
        var name: String
        var categories: [String]
        var brand: String
        var slug: String
        var id: String
    }
}


struct Config: Codable {
    let _id: String
    let colorHex: String
    let size: String
    let weight: String
    let imagesUrl: String
    let images: [String]
    let isActive: Bool
    let price: Double
    let discountPrice: Double
    let productDescription: String
    let type: String
    let productionPrice: Double
    let stock: [Stock]?
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
