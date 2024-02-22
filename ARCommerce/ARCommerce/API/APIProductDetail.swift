//
//  APIProductDetail.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 10/1/24.
//

import Foundation

class APIProductDetail: NetworkRequestable {
    func addConfigurations(product: ProductV1, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let urlString = "\(Self.baseURL)api/v1/products/config/\(product.id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var mainBody : [String: Array] = [
            "configs": []
        ]
        
        for configuration in listConfigurations {
            let images: [String] = configuration.images.compactMap { $0 }
            
            var stocks: [[String: Any]] = []
            
            configuration.stock.forEach({
                let stock: [String: Any] = [
                    "location": $0.location._id,
                    "quantity": $0.quantityText,
                    "size": $0.size,
                ]
                stocks.append(stock)
            })
            
            print("stocks", stocks)
            
            let requestBody: [String: Any] = [
                "price": configuration.price,
                "productionPrice": configuration.productionPrice,
                "discountPrice": configuration.discountPrice,
                "type": configuration.type,
                "size": configuration.size,
                "weight": configuration.weight,
                "colorHex": configuration.colorHex,
                "productDescription": configuration.productDescription,
                "isActive": configuration.isActive,
                "images": images,
                "stock": stocks
            ]
            print("requestBody", requestBody)
            mainBody["configs"]?.append(requestBody)
        }
        
        
        
        let bodyData = try JSONSerialization.data(withJSONObject: mainBody)
        let request = APIRequest(url: url, method: .post, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let productJson = dataJSON["product"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: productJson)
            let decoder = JSONDecoder()
            
            return try decoder.decode(ProductConfigResult.self, from: dataProduct)
        } catch {
            throw error
        }
    }
    
    func getProductcConfiguration(productId: String) async throws -> [Config] {
        let urlString = "\(Self.baseURL)api/v1/products/config/\(productId)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let request = APIRequest(url: url, method: .get, body: nil)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }
            guard let dataJSON2 = dataJSON["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }
            
            guard let configsJson = dataJSON2["configs"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: configsJson)
            let decoder = JSONDecoder()
            
            return try decoder.decode([Config].self, from: dataProduct)
        } catch {
            throw error
        }
    }
    
    func updateConfigurations(product: ProductV1, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let urlString = "\(Self.baseURL)api/v1/products/config/\(product.id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var mainBody : [String: Array] = [
            "configs": []
        ]
        
        for configuration in listConfigurations {
            let images: [String] = configuration.images.compactMap { $0 }
            
            let requestBody: [String: Any] = [
                "price": configuration.price,
                "productionPrice": configuration.productionPrice,
                "colorHex": configuration.colorHex,
                "productDescription": configuration.productDescription,
                "isActive": configuration.isActive,
                "images": images
            ]

            mainBody["configs"]?.append(requestBody)
        }
        
        
        
        let bodyData = try JSONSerialization.data(withJSONObject: mainBody)
        let request = APIRequest(url: url, method: .patch, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let productJson = dataJSON["product"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: productJson)
            let decoder = JSONDecoder()
            
            return try decoder.decode(ProductConfigResult.self, from: dataProduct)
        } catch {
            throw error
        }
    }
}
