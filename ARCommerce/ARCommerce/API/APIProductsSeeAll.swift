//
//  APIProductsSeeAll.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 13/1/24.
//

import Foundation

class APIProductsSeeAll: NetworkRequestable {
    func getAllProducts(page: Int) async throws -> [ProductV1] {
        let urlString = "\(Self.baseURL)api/v1/products?page=\(page)&limit=10"
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

            guard let productJson = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataProduct = try JSONSerialization.data(withJSONObject: productJson)
            
            let decoder = JSONDecoder()
            let products = try decoder.decode([ProductV1].self, from: dataProduct)
            products.forEach({ print("brand, supplier, categories", $0.brand.name, $0.suppliers.first, $0.categories.first?.name) })
            return products
        } catch {
            throw error
        }
    }
    
    func deleteProduct(id: String) async throws -> Bool {
        let urlString = "\(Self.baseURL)api/v1/products/\(id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let request = APIRequest(url: url, method: .delete, body: nil)
        
        do {
            return try await performRequest(request: request)
        } catch {
            throw error
        }
    }
    
    func activateProduct(id: String) async throws -> Bool {
        let urlString = "\(Self.baseURL)api/v1/products/\(id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let requestBody: [String: Any] = [
            "isActive": true
            
        ]
    
        let bodyData = try JSONSerialization.data(withJSONObject: requestBody)
        let request = APIRequest(url: url, method: .delete, body: bodyData)
        
        do {
            return try await performRequest(request: request)
        } catch {
            throw error
        }
    }
}
