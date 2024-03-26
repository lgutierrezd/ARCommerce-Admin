//
//  Location.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import Foundation

struct LocationsResponse: Codable {
    let status: String
    var results: Int
    var data: Data
    struct Data: Codable {
        let data: [Location]
    }
}

struct LocationResponse: Codable {
    let status: String
    var data: Data
    struct Data: Codable {
        let data: Location
    }
}

struct Location: Codable, Equatable, Identifiable, Hashable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id && lhs.locationName == rhs.locationName && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    
    var id: String
    var locationName: String
    var lat: String
    var lon: String
    
    init(id: String, locationName: String, lat: String, lon: String) {
        self.id = id
        self.locationName = locationName
        self.lat = lat
        self.lon = lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.locationName = try container.decode(String.self, forKey: .locationName)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lon = try container.decode(String.self, forKey: .lon)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case locationName
        case lat
        case lon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(locationName)
        hasher.combine(lat)
        hasher.combine(lon)
    }
}
