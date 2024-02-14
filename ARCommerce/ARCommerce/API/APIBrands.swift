//
//  APIBrands.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation

class APIBrands: NetworkRequestable {
    func getBrands() async throws -> [Brand] {
        let urlString = "\(Self.baseURL)api/v1/brand"
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
            guard let json = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let data = try JSONSerialization.data(withJSONObject: json)
            let decoder = JSONDecoder()
            
            return try decoder.decode([Brand].self, from: data)
        } catch {
            throw error
        }
    }
    
    func addBrand(brand: Brand) async throws -> Brand {
        let urlString = "\(Self.baseURL)api/v1/brand"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "name": brand.name,
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
            guard let json = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let data = try JSONSerialization.data(withJSONObject: json)
            let decoder = JSONDecoder()
            
            return try decoder.decode(Brand.self, from: data)
        } catch {
            throw error
        }
    }
    
    func updateBrand(brand: Brand) async throws -> Brand {
        let urlString = "\(Self.baseURL)api/v1/brand/\(brand.id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "name": brand.name,
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
            guard let json = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let data = try JSONSerialization.data(withJSONObject: json)
            let decoder = JSONDecoder()
            
            return try decoder.decode(Brand.self, from: data)
        } catch {
            throw error
        }
    }
    
    func deleteBrand(brand: Brand) async throws -> Bool {
        let urlString = "\(Self.baseURL)api/v1/brand/\(brand.id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let request = APIRequest(url: url, method: .delete, body: nil)
        
        do {
            let responseData: Bool = try await performRequest(request: request)
            return responseData
        } catch {
            throw error
        }
    }
}
