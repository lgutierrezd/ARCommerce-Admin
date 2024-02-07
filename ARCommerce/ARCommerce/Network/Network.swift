//
//  Network.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

// Enumeración para representar errores de red
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case invalidData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

// Estructura que representa una solicitud de red
struct APIRequest {
    let url: URL
    let method: HTTPMethod
    let body: Data?
}

// Protocolo que define la funcionalidad básica de la red
protocol NetworkRequestable {
    func performRequest(request: APIRequest) async throws -> Data
    func performRequest(request: APIRequest) async throws -> Bool
}


// Implementación de NetworkProtocol
extension NetworkRequestable {
    fileprivate func saveCookies(_ httpResponse: HTTPURLResponse) {
        if let allHeaderFields = httpResponse.allHeaderFields as? [String: String] {
            if let setCookieHeader = allHeaderFields["Set-Cookie"] {
                
                let cookieComponents = setCookieHeader.components(separatedBy: "; ")
                
                var cookieProperties = [HTTPCookiePropertyKey: Any]()
                
                for component in cookieComponents {
                    let keyValuePair = component.components(separatedBy: "=")
                    if keyValuePair.count == 2 {
                        let key = keyValuePair[0].trimmingCharacters(in: .whitespacesAndNewlines)
                        let value = keyValuePair[1].trimmingCharacters(in: .whitespacesAndNewlines)
                        if key == "jwt" {
                            cookieProperties[.name] = "jwt"
                            cookieProperties[.value] = value
                        } else {
                            cookieProperties[HTTPCookiePropertyKey(key)] = value
                        }
                    }
                }
                
                if let expiresString = cookieProperties[HTTPCookiePropertyKey("Expires")] as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
                    
                    if let expiresDate = dateFormatter.date(from: expiresString) {
                        cookieProperties[HTTPCookiePropertyKey.expires] = expiresDate
                    }
                }
                cookieProperties[HTTPCookiePropertyKey.secure] = "TRUE"
                if let cookie = HTTPCookie(properties: cookieProperties) {
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
        }
    }
    
    func performRequest(request: APIRequest) async throws -> Data {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        if let storedCookies = HTTPCookieStorage.shared.cookies {
            let cookieHeader = HTTPCookie.requestHeaderFields(with: storedCookies)
            urlRequest.allHTTPHeaderFields = cookieHeader
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.requestFailed(NSError(domain: "Invalid response", code: 0, userInfo: nil))
            }
            if ((response.url?.absoluteString.contains("/api/v1/users/login")) != nil) {
                saveCookies(httpResponse)
            }
            
            let statusCode = httpResponse.statusCode
            
            if statusCode == 401 || data.isEmpty {
                throw CustomError.credentialError
            }
            
            if statusCode == 500 {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    throw NetworkError.invalidData
                }
            
                guard let message = jsonResponse["message"] as? String else {
                    throw NetworkError.invalidData
                }
                
                throw CustomError.internalServerError(message)
            }
            
            if statusCode == 404 {
                throw CustomError.notFound
            }
            
            return data
        } catch {
            throw error
        }
    }
    
    func performRequest(request: APIRequest) async throws -> Bool {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        if let storedCookies = HTTPCookieStorage.shared.cookies {
            let cookieHeader = HTTPCookie.requestHeaderFields(with: storedCookies)
            urlRequest.allHTTPHeaderFields = cookieHeader
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.requestFailed(NSError(domain: "Invalid response", code: 0, userInfo: nil))
            }
            if ((response.url?.absoluteString.contains("/api/v1/users/login")) != nil) {
                saveCookies(httpResponse)
            }
            
            let statusCode = httpResponse.statusCode
            
            if statusCode == 401 {
                throw CustomError.credentialError
            }
            
            if statusCode == 500 {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    throw NetworkError.invalidData
                }
            
                guard let message = jsonResponse["message"] as? String else {
                    throw NetworkError.invalidData
                }
                
                throw CustomError.internalServerError(message)
            }
            if statusCode == 204 {
                return true
            }
            
            return false
        } catch {
            throw error
        }
    }
}
