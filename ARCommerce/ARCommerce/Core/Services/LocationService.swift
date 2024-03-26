//
//  LocationService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/25/24.
//

import Foundation
import Combine

protocol LocationServiceType {
    func getLocations(page: String, limit: String) -> AnyPublisher<LocationsResponse, Error>
    func addLocation(location: Location) -> AnyPublisher<LocationResponse, Error>
    func updateLocation(location: Location) -> AnyPublisher<LocationResponse, Error>
    func deleteLocation(id: String) -> AnyPublisher<Bool, Error>
}

struct LocationService: LocationServiceType {
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getLocations(page: String, limit: String) -> AnyPublisher<LocationsResponse, Error> {
        requester.get(target: LocationsTarget.getLocations(page: page, limit: limit))
    }
    
    func addLocation(location: Location) -> AnyPublisher<LocationResponse, Error> {
        requester.post(target: LocationsTarget.addLocation(location: location))
    }
    
    func updateLocation(location: Location) -> AnyPublisher<LocationResponse, Error> {
        requester.patch(target: LocationsTarget.updateLocation(location: location))
    }
    
    func deleteLocation(id: String) -> AnyPublisher<Bool, Error> {
        requester.delete(target: LocationsTarget.deleteLocation(id: id))
    }
}
