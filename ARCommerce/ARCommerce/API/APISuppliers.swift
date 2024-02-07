//
//  APISuppliers.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation

class APISuppliers: NetworkRequestable {
    func getSuppliers() async throws -> [Supplier] {
        let urlString = "http://192.168.100.28:3000/api/v1/supplier"
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
            
            return try decoder.decode([Supplier].self, from: data)
        } catch {
            throw error
        }
    }
    
    func addSuppliers(supplier: Supplier) async throws -> Supplier {
        let urlString = "http://192.168.100.28:3000/api/v1/supplier"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "name": supplier.name,
            "email": supplier.email,
            "phone": supplier.phone
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
            
            return try decoder.decode(Supplier.self, from: data)
        } catch {
            throw error
        }
    }
    
    func getUpdateDeleteSuppliers(id: String, supplier: Supplier?, method: HTTPMethod) async throws -> Supplier? {
        let urlString = "http://192.168.100.28:3000/api/v1/supplier/\(id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        var requestBody: [String: Any] = [String: Any]()
        if method  == .patch {
            guard let supplier = supplier else {
                throw CustomError.notFound
            }
            requestBody = [
                "name": supplier.name,
                "email": supplier.email,
                "phone": supplier.phone
            ]
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: requestBody)

        
        let request = APIRequest(url: url, method: method, body: bodyData)
        
        do {
            var responseData: Data?
            if method == .delete {
                if try await performRequest(request: request) {
                    return nil
                }
            } else {
                responseData = try await performRequest(request: request)
            }
            guard let dataObject: Data = responseData else { throw NetworkError.invalidData }
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: dataObject) as? [String: Any] else {
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
            
            return try decoder.decode(Supplier.self, from: data)
        } catch {
            throw error
        }
    }
}
