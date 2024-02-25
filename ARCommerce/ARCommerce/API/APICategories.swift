//
//  APICategories.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation

class APICategories: NetworkRequestable {
    func getCategories(page: Int, limit: Int) async throws -> [ARCommerce.Category] {
        let urlString = "\(Self.baseURL)api/v1/categories?page=\(page)&limit=\(limit)"
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
            guard let userJSON = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataUser = try JSONSerialization.data(withJSONObject: userJSON)
            let decoder = JSONDecoder()
            let categories = try decoder.decode([ARCommerce.Category].self, from: dataUser)
            
            return categories
        } catch {
            throw error
        }
    }
    
    func getCategories(page: Int, limit: Int) async throws -> [ARCommerce.CategoryV1] {
        let urlString = "\(Self.baseURL)api/v1/categories?page=\(page)&limit=\(limit)"
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
            guard let userJSON = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataUser = try JSONSerialization.data(withJSONObject: userJSON)
            let decoder = JSONDecoder()
            let categories = try decoder.decode([ARCommerce.CategoryV1].self, from: dataUser)
            
            return categories
        } catch {
            throw error
        }
    }
    
    func getCategory(id: String) async throws -> ARCommerce.Category {
        let urlString = "\(Self.baseURL)api/v1/categories/\(id)"
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
            guard let userJSON = dataJSON["data"] else {
                throw NetworkError.invalidData
            }
            
            let dataUser = try JSONSerialization.data(withJSONObject: userJSON)
            let decoder = JSONDecoder()
            let categories = try decoder.decode(ARCommerce.Category.self, from: dataUser)
            
            return categories
        } catch {
            throw error
        }
    }
    
    func addCategory(category: ARCommerce.CategoryV1) async throws -> ARCommerce.CategoryV1 {
        let urlString = "\(Self.baseURL)api/v1/categories"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var requestBody: [String: Any] = [:]
        
        if let _isIdEmpty = category.childs?.isEmpty {
            if _isIdEmpty {
                requestBody = [
                    "name": category.name,
                    "setup": []
                ]
            } else {
                requestBody = [
                    "name": category.name,
                    "childs": category.childs ?? [],
                    "setup": []
                ]
            }
            
        } else {
            requestBody = [
                "name": category.name,
                "setup": []
            ]
        }
        
        if let setup = category.setup {
            var setupArray: [[String: Any]] = []
             setup.forEach { d in
                 let sp: [String: Any] = ["key": d.key, "value": d.value]
                 setupArray.append(sp)
             }
             requestBody["setup"] = setupArray
        }
        
        
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
            
            return try decoder.decode(CategoryV1.self, from: data)
        } catch {
            throw error
        }
    }
    
    func updateCategory(category: ARCommerce.CategoryV1) async throws -> ARCommerce.CategoryV1 {
        let urlString = "\(Self.baseURL)api/v1/categories/\(category._id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var requestBody: [String: Any] = [:]
        
        if let _isIdEmpty = category.childs?.isEmpty, let isMain = category.isMain {
            if _isIdEmpty {
                requestBody = [
                    "name": category.name,
                    "isMain": isMain,
                    "setup": []
                ]
            } else {
                requestBody = [
                    "name": category.name,
                    "childs": category.childs ?? [],
                    "isMain": isMain,
                    "setup": []
                ]
            }
            
        } else {
            requestBody = [
                "name": category.name,
                "setup": []
            ]
        }
        
        if let setup = category.setup {
            var setupArray: [[String: Any]] = []
             setup.forEach { d in
                 let sp: [String: Any] = ["key": d.key, "value": d.value]
                 setupArray.append(sp)
             }
             requestBody["setup"] = setupArray
        }
        
        
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
            
            return try decoder.decode(CategoryV1.self, from: data)
        } catch {
            throw error
        }
    }
    
    func deleteCategory(id: String) async throws -> Bool {
        let urlString = "\(Self.baseURL)api/v1/categories/\(id)"
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
    
}
