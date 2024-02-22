//
//  CoreLocation.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import Foundation

class CoreLocation {
    func getLocations() async throws -> [Location] {
        do {
            let apiLocations = APILocation()
            let Locations = try await apiLocations.getLocations()
            return Locations
        } catch {
            throw error
        }
    }
    
    func addLocation(Location: Location) async throws -> Location {
        do {
            let apiLocations = APILocation()
            let Location = try await apiLocations.addLocation(location: Location)
            return Location
        } catch {
            throw error
        }
    }
    
    func updateLocation(Location: Location) async throws -> Location {
        do {
            let apiLocations = APILocation()
            return try await apiLocations.updateLocation(location: Location)
        } catch {
            throw error
        }
    }
    
    func deleteLocation(Location: Location) async throws -> Bool {
        do {
            let apiLocations = APILocation()
            return try await apiLocations.deleteLocation(location: Location)
            
        } catch {
            throw error
        }
    }

}
