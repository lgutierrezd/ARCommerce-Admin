//
//  APIUsers.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 8/12/23.
//

import Foundation
/*
struct APIUsers: NetworkRequestable {
    func login(email: String, password: String) async throws -> User {
        let urlString = "\(Self.baseURL)api/v1/users/login"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let bodyData = try? JSONEncoder().encode(["email": email, "password": password])
        
        let request = APIRequest(url: url, method: .post, body: bodyData)
        
        do {
            let responseData: Data = try await performRequest(request: request)
            
            guard let jsonResponse = try JSONSerialization.jsonObject(with: responseData) as? [String: Any] else {
                throw NetworkError.invalidData
            }
            guard let dataJSON = jsonResponse["data"] as? [String: Any] else {
                throw NetworkError.invalidData
            }
            guard let userJSON = dataJSON["user"] else {
                throw NetworkError.invalidData
            }
            
            let dataUser = try JSONSerialization.data(withJSONObject: userJSON)
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: dataUser)
            
            return user
        } catch {
            throw error
        }
    }
}
*/
