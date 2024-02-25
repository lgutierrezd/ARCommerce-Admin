//
//  Brand.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftData

@Model
class Brand: Codable, Equatable, Hashable, Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
