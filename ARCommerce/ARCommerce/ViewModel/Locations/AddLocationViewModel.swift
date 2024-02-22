//
//  AddLocationViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

class AddLocationViewModel: ObservableObject {
    @Published var locationName: String = ""
    @Published var lat: String = ""
    @Published var lon: String = ""
    
    func addLocation() async throws -> Location {
        let coreLocation = CoreLocation()
        return try await coreLocation.addLocation(Location: Location(_id: "", locationName: locationName, lat: lat, lon: lon))
    }
}
