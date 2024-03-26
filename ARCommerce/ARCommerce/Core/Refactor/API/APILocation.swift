//
//  APILocation.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//
/*
import Foundation

struct APILocation: NetworkRequestable {
    func getLocations() async throws -> [Location] {
        let urlString = "\(Self.baseURL)api/v1/location"
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
            
            return try decoder.decode([Location].self, from: data)
        } catch {
            throw error
        }
    }
    
    func addLocation(location: Location) async throws -> Location {
        let urlString = "\(Self.baseURL)api/v1/location"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "locationName": location.locationName,
            "lat": location.lat,
            "lon": location.lon
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
            
            return try decoder.decode(Location.self, from: data)
        } catch {
            throw error
        }
    }
    
    func updateLocation(location: Location) async throws -> Location {
        let urlString = "\(Self.baseURL)api/v1/location/\(location._id)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "locationName": location.locationName,
            "lat": location.lat,
            "lon": location.lon
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
            
            return try decoder.decode(Location.self, from: data)
        } catch {
            throw error
        }
    }
    
    func deleteLocation(location: Location) async throws -> Bool {
        let urlString = "\(Self.baseURL)api/v1/location/\(location._id)"
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
*/
