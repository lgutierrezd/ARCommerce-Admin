//
//  SeeAllLocationsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

class SeeAllLocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
    
    @Published var selectedLocation: Location?
    
    let locationService: LocationServiceType
    
    init(
        locations: [Location] = [], 
        selectedLocation: Location? = nil,
        locationService: LocationServiceType = LocationService()
    ) {
        self.locations = locations
        self.selectedLocation = selectedLocation
        self.locationService = locationService
    }
    
}
