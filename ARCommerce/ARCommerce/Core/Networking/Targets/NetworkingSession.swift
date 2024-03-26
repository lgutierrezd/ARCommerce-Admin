//
//  NetworkingSession.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum NetworkingSession {
    // MARK: - Default Networking Session
    static let `default`: Session = {
        let configuration: URLSessionConfiguration = .default
        configuration.headers = .default
        configuration.httpCookieAcceptPolicy = .always
        
        return .init(configuration: configuration)
    }()
}
