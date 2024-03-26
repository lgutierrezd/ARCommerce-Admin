//
//  Category.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftData

struct Setup: Identifiable, Codable, Hashable {
    let id: String
    var key: String
    var value: String
    
    init(id: String, key: String, value: String) {
        self.id = id
        self.key = key
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(key)
        hasher.combine(value)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case key
        case value
    }
    
    static func == (lhs: Setup, rhs: Setup) -> Bool {
        return lhs.id == rhs.id && lhs.key == rhs.key && lhs.value == rhs.value
    }
}

struct CategoriesResponse: Codable {
    let status: String
    let results: Int
    let data: Data
    struct Data: Codable {
        let data: [Category]
    }
}

struct CategoryResponse: Codable {
    let status: String
    let data: Data
    struct Data: Codable {
        let data: Category
    }
}

struct Category: Codable, Identifiable, Equatable, Hashable {
    var id: String
    var name: String
    var childs: [String]? = nil
    var isMain: Bool? = false
    var setup: [Setup]? = nil
    
    init() {
        self.id = ""
        self.name = ""
        self.isMain = false
    }
    
    init(_id: String, name: String, childs: [String]? = nil, isMain:Bool? = false ,setup: [Setup]? = nil) {
        self.id = _id
        self.name = name
        self.childs = childs
        self.isMain = isMain
        self.setup = setup
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        if let setup = try? container.decode([Setup].self, forKey: .setup) {
            self.setup = setup
        }
        self.isMain = try? container.decode(Bool.self, forKey: .isMain)
        if let childs = try? container.decode([String].self, forKey: .childs) {
            self.childs = childs
        } else {
            self.childs = nil
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(setup, forKey: .setup)
        try container.encode(isMain, forKey: .isMain)
        try container.encode(childs, forKey: .childs)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case childs
        case isMain
        case setup
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(childs)
        hasher.combine(isMain)
        hasher.combine(setup)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.childs == rhs.childs && lhs.setup == rhs.setup && lhs.isMain == rhs.isMain
    }
}
