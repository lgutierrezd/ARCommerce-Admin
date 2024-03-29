//
//  Supplier.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftData

struct SuppliersResponse: Codable {
    let status: String
    var results: Int
    var data: Data
    struct Data: Codable {
        let data: [Supplier]
    }
}

struct SupplierResponse: Codable {
    let status: String
    var data: Data
    struct Data: Codable {
        let data: Supplier
    }
}

struct Supplier: Codable, Equatable, Hashable, Identifiable {
    let id: String
    var name: String
    var email: String
    var phone: String
    
    init(id: String, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case email
        case phone
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
    }

}
