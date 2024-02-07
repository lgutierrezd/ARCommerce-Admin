//
//  Core+User.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

extension CoreUser {
    func login(email: String, password: String) async throws -> User {
        do {
            let apiUser = APIUsers()
            let user = try await apiUser.login(email: email, password: password);
            return user
        } catch {
            throw error
        }
    }
    
}
