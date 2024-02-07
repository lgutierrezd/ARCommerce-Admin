//
//  Category.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftData

class Setup: Identifiable, Codable, Hashable {
    let _id: String
    var key: String
    var value: String
    
    init(_id: String, key: String, value: String) {
        self._id = _id
        self.key = key
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
        hasher.combine(key)
        hasher.combine(value)
    }
    
    static func == (lhs: Setup, rhs: Setup) -> Bool {
        return lhs._id == rhs._id && lhs.key == rhs.key && lhs.value == rhs.value
    }
}


@Model
class Category: Hashable, Codable, Equatable {
    @Attribute(.unique) var _id: String
    var name: String
    var parent: ARCommerce.Category? = nil
    var setup: [Setup]? = nil
    
    init(_id: String, name: String, parent: Category? = nil, setup: [Setup]? = nil) {
        self._id = _id
        self.name = name
        self.parent = parent
        self.setup = setup
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: .name)
        if let setup = try? container.decode([Setup].self, forKey: .setup) {
            self.setup = setup
        }
        if let parent = try? container.decode(Category.self, forKey: .parent) {
            self.parent = parent
        } else {
            self.parent = nil
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(name, forKey: .name)
        try container.encode(setup, forKey: .setup)
        try container.encode(parent, forKey: .parent)
    }
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case name
        case parent
        case setup
    }
}

class CategoryV1: Codable, Identifiable, Equatable, Hashable {
    var _id: String
    var name: String
    var parent: CategoryV1? = nil
    var setup: [Setup]? = nil
    
    init() {
        self._id = ""
        self.name = ""
    }
    
    init(_id: String, name: String, parent: CategoryV1? = nil, setup: [Setup]? = nil) {
        self._id = _id
        self.name = name
        self.parent = parent
        self.setup = setup
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: .name)
        if let setup = try? container.decode([Setup].self, forKey: .setup) {
            self.setup = setup
        }
        if let parent = try? container.decode(CategoryV1.self, forKey: .parent) {
            self.parent = parent
        } else {
            self.parent = nil
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(name, forKey: .name)
        try container.encode(setup, forKey: .setup)
        try container.encode(parent, forKey: .parent)
    }
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case name
        case parent
        case setup
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
        hasher.combine(name)
        hasher.combine(parent)
        hasher.combine(setup)
    }
    
    static func == (lhs: CategoryV1, rhs: CategoryV1) -> Bool {
        return lhs._id == rhs._id && lhs.name == rhs.name && lhs.parent == rhs.parent && lhs.setup == rhs.setup
    }
}
