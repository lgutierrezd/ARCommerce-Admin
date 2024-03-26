//
//  AddLocationViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

class AddLocationViewModel: ObservableObject {
    @Published var location: Location?
    
    let locationService: LocationServiceType
    
    init(
        location: Location = Location(
                                        id: "",
                                        locationName: "",
                                        lat: "",
                                        lon: ""
                                    ),
        locationService: LocationServiceType = LocationService()
    ) {
        self.location = location
        self.locationService = locationService
    }
}
