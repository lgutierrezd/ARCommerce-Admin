//
//  LocationsTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum LocationsTarget: NetworkingTargetType {
    case getLocations(page: String, limit: String)
    case getLocation(id: String)
    case addLocation(location: Location)
    case updateLocation(location: Location)
    case deleteLocation(id: String)
    
    var requestPath: String {
        switch self {
        case .getLocations(page: _, limit: _):
            return "api/v1/location"
        case .getLocation(id: let id):
            return "api/v1/location/\(id)"
        case .addLocation(location: _):
            return "api/v1/location"
        case .updateLocation(location: let location):
            return "api/v1/location/\(location.id)"
        case .deleteLocation(id: let id):
            return "api/v1/location/\(id)"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .getLocations(page: _, limit: _):
            return .get
        case .getLocation(id: _):
            return .get
        case .addLocation(location: _):
            return .post
        case .updateLocation(location: _):
            return .patch
        case .deleteLocation(id: _):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getLocations(page: let page, limit: let limit):
            let parameters = ["page": page, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getLocation(id: _):
            return .requestPlain
        case .addLocation(location: let location):
            let requestBody: [String: Any] = [
                "locationName": location.locationName,
                "lat": location.lat,
                "lon": location.lon
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateLocation(location: let location):
            let requestBody: [String: Any] = [
                "locationName": location.locationName,
                "lat": location.lat,
                "lon": location.lon
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .deleteLocation(id: _):
            return .requestPlain
        }
    }
    
    
}
