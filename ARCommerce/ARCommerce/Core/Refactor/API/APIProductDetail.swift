//
//  APIProductDetail.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 10/1/24.
//
/*
import Foundation

struct APIProductDetail: NetworkRequestable {
    func addConfigurations(productId: String, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let urlString = "\(Self.baseURL)api/v1/products/config/\(productId)"
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
                    "quantity": Int($0.quantityText) ?? 0,
                    "size": $0.size,
                ]
                stocks.append(stock)
            })
            
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
            
            guard let dataJSON2 = dataJSON["data"] as? [[String: Any]] else {
                throw NetworkError.invalidData
            }
            
            guard let configsJson = dataJSON2.first?["configs"] else {
                throw NetworkError.invalidData
            }
            
            var configs: [Config] = []

            if let configJSON = try? JSONSerialization.data(withJSONObject: configsJson) {
                do {
                    let config = try JSONDecoder().decode([Config].self, from: configJSON)
                    configs = config
                } catch {
                    print("Error decoding config: \(error)")
                }
            }

            return configs
        } catch {
            throw error
        }
    }
    
    func updateConfigurations(productId: String, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let urlString = "\(Self.baseURL)api/v1/products/config/\(productId)"
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
*/
