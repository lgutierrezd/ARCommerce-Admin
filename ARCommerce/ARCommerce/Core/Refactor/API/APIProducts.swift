//
//  APIProducts.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation
/*
struct APIProducts: NetworkRequestable {
    func addProduct(product: Product) async throws -> Product {
        let urlString = "\(Self.baseURL)api/v1/products"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        
        let requestBody: [String: Any] = [
            "name": product.name,
            "categories": product.categories.compactMap( {$0} ),
            "brand": product.brand,
            "suppliers": product.suppliers.compactMap( {$0} ),
            "isActive": product.isActive,
            "config": []
        ]
        
        let bodyData = try JSONSerialization.data(withJSONObject: requestBody)
        let request = APIRequest(url: url, method: .post, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }
            
            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }
            
            guard let productJson = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: productJson)
            let decoder = JSONDecoder()
            
            return try decoder.decode(Product.self, from: dataProduct)
        } catch {
            throw error
        }
    }
    
    func updateProduct(product: Product) async throws -> Product {
        let urlString = "\(Self.baseURL)api/v1/products/\(product.id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "name": product.name,
            "slug": product.slug,
            "categories": product.categories.compactMap({ $0 }),
            "brand": product.brand,
            "suppliers": product.suppliers.compactMap { $0 },
            "isActive": product.isActive,
            "config": []
        ]
        
        let bodyData = try JSONSerialization.data(withJSONObject: requestBody)
        let request = APIRequest(url: url, method: .patch, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }

            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }
            
            guard let productJson = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: productJson)
            let decoder = JSONDecoder()
            
            return try decoder.decode(Product.self, from: dataProduct)
        } catch {
            throw error
        }
    }
}
*/
