//
//  SeeAllLocationsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

class SeeAllLocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
    
    @Published var id: String = ""
    @Published var locationName: String = ""
    @Published var lat: String = ""
    @Published var lon: String = ""
    
    @Published var stocks: [Stock] = []
    
    @MainActor func getAllLocations() async throws {
        let coreLocation = CoreLocation()
        self.locations = try await coreLocation.getLocations()
    }
    
    func updateLocation() async throws -> Location {
        let coreLocation = CoreLocation()
        return try await coreLocation.updateLocation(Location: Location(_id: id, locationName: locationName, lat: lat, lon: lon))
    }
    
    func deleteLocation(location: Location) async throws -> Bool {
        let coreLocation = CoreLocation()
        return try await coreLocation.deleteLocation(Location: location)
    }
    
}
