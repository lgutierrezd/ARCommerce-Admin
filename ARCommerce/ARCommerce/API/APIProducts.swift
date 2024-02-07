//
//  APIProducts.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation

class APIProducts: NetworkRequestable {
    func addProduct(name: String, brand: Brand, category: ARCommerce.Category, suppliers: Set<Supplier>) async throws -> Product {
        let urlString = "http://192.168.100.28:3000/api/v1/products"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let suppliers: [String] = suppliers.compactMap { $0.id }
        
        let requestBody: [String: Any] = [
            "name": name,
            "category": category._id,
            "brand": brand.id,
            "suppliers": suppliers,
            "isActive": true,
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
    
    func updateProduct(id: String, name: String, brand: Brand, category: ARCommerce.Category, suppliers: Set<Supplier>) async throws -> Product {
        let urlString = "http://192.168.100.28:3000/api/v1/products/\(id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let suppliers: [String] = suppliers.compactMap { $0.id }
        
        let requestBody: [String: Any] = [
            "name": name,
            "category": category._id,
            "brand": brand.id,
            "suppliers": suppliers,
            "isActive": true,
            "config": []
        ]
        
        let bodyData = try JSONSerialization.data(withJSONObject: requestBody)
        let request = APIRequest(url: url, method: .patch, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }
            print("jsonResponse \(jsonResponse)")
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

