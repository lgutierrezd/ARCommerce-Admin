//
//  Location.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import Foundation

class Location: Codable, Equatable, Identifiable, Hashable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs._id == rhs._id && lhs.locationName == rhs.locationName && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
    
    var _id: String
    var locationName: String
    var lat: String
    var lon: String
    
    init(_id: String, locationName: String, lat: String, lon: String) {
        self._id = _id
        self.locationName = locationName
        self.lat = lat
        self.lon = lon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.locationName = try container.decode(String.self, forKey: .locationName)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lon = try container.decode(String.self, forKey: .lon)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
        hasher.combine(locationName)
        hasher.combine(lat)
        hasher.combine(lon)
    }
}
