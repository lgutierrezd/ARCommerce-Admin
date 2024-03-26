//
//  ARCommerceApp.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import SwiftUI

@main
struct ARCommerceApp: App {
    @StateObject var appSettings = AppSettings()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
                .onAppear() {
                    if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken"), !jwtToken.isEmpty {
                        appSettings.isLoggedIn = true
                    }
                }
        }
    }
}
