//
//  MoyaProvider+Extension.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

// MARK: - Moya Provider Extension
extension MoyaProvider {
    // MARK: - Custom Networking Provider
    static func networkingProvider() -> MoyaProvider<MultiTarget> {
        let session = NetworkingSession.default
        let loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        
        return MoyaProvider<MultiTarget>(session: session, plugins: [loggerPlugin])
    }
}
