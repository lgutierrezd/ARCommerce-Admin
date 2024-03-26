//
//  AppConfigurationManager.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation

// MARK: - App Configuration Manager Type
protocol AppConfigurationManagerType {
    func getAppConfiguration(with name: AppConfigurationNames) -> String?
}

// MARK: - AppConfiguration Manager
class AppConfigurationManager: AppConfigurationManagerType {
    // MARK: - Shared Instance
    static let shared: AppConfigurationManagerType = AppConfigurationManager()
    
    // MARK: - Functionality
    func getAppConfiguration(with name: AppConfigurationNames) -> String? {
        Bundle.main.object(forInfoDictionaryKey: name.rawValue) as? String
    }
}

// MARK: - App Configuration Names
enum AppConfigurationNames: String {
    case baseURL = "API_BASE_URL"
}
