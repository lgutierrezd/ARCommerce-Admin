//
//  NetworkingTargetType.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

// MARK: - Networking Target Type
protocol NetworkingTargetType: TargetType {
    var requestBaseURL: URL { get }
    var requestPath: String { get }
    var requestHeaders: [String: String]? { get }
    var requestMethod: Moya.Method { get }
}

// MARK: - Networking Target Type default configuration
extension NetworkingTargetType {
    var requestBaseURL: URL {
        guard let baseURL = AppConfigurationManager.shared.getAppConfiguration(with: .baseURL) else {
            return URL(string: "www.apple.com")!
        }
        return URL(string: baseURL)!
    }
    
    var requestHeaders: [String: String]? {
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
            return ["ContentType": "application/json", "Authorization": "Bearer \(jwtToken)"]
        } else {
            return ["ContentType": "application/json"]
        }
    }
}

extension NetworkingTargetType {
    var baseURL: URL {
        requestBaseURL
    }
    
    var path: String {
        requestPath
    }
    
    var method: Moya.Method {
        requestMethod
    }
    
    var headers: [String : String]? {
        requestHeaders
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    func parametersAsDictionary<T: Encodable>(_ parameters: T,
                                              with encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        encoder.encodeAsDictionary(parameters) ?? [:]
    }
}
