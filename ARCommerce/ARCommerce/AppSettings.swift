//
//  AppSettings.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 21/12/23.
//

import SwiftUI

final class AppSettings: ObservableObject {
    private let userDefaults: UserDefaults
    private let queue: DispatchQueue = DispatchQueue(label: "appSettings", qos: .userInitiated, attributes: .concurrent)
    @Published var themeColor: Color = .blue
    @Published var isLoggedIn = false
    @Published var user: User
    
    @Published var selectedCategoryId: MenuItem.ID?
    @Published var selectedItem: MenuItem?
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.user = (try? userDefaults.getObject(forKey: "user", castTo: User.self)) ?? User(_id: "", name: "", email: "", role: "")
           
    }
    
    func loadCookies() {
        let storedCookies = HTTPCookieStorage.shared.cookies
        if let jwtCookie = storedCookies?.first(where: { $0.name == "jwt" }) {
            if let expires = jwtCookie.expiresDate {
                if expires  > Date.now {
                    self.isLoggedIn = true
                }
            }
        }
    }
    
    func saveUser() {
        queue.async(flags: .barrier) { [weak self] in
            self?.userDefaults.setObject(self?.user, forKey: "user")
        }
    }
    
    func saveMenuStateCategoryId() {
        queue.async(flags: .barrier) { [weak self] in
            self?.userDefaults.setObject(self?.selectedCategoryId, forKey: "selectedCategoryId")
        }
    }
    
    func saveMenuStateItem() {
        queue.async(flags: .barrier) { [weak self] in
            self?.userDefaults.setObject(self?.selectedItem, forKey: "selectedItem")
        }
    }
    
    func loadMenuState() {
        selectedCategoryId = try? userDefaults.getObject(forKey: "selectedCategoryId", castTo: MenuItem.ID.self)
        selectedItem = try? userDefaults.getObject(forKey: "selectedItem", castTo: MenuItem.self)
    }
}

extension UserDefaults {
    func getObject<T: Decodable>(forKey key: String, castTo type: T.Type) throws -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try JSONDecoder().decode(type, from: data)
    }

    func setObject<T: Encodable>(_ object: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        set(data, forKey: key)
    }
}
