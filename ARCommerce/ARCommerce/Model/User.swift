//
//  User.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

struct UserResponse: Codable {
    let status: String
    let token: String
    let data: Data
    
    struct Data: Codable {
        let user: User
    }
}

struct User: Codable, Equatable {
    let _id: String
    let name: String
    let email: String
    let role: String
    var eRole: UserRole {
        get {
            return role == "admin" ? .admin : .user
        }
    }
}

enum UserRole: Decodable {
    case user
    case admin
}

