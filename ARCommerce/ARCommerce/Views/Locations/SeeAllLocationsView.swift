//
//  SeeAllLocationsView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI
import Combine

struct SeeAllLocationsView: View {
    @StateObject var seeAllLocationsViewModel = SeeAllLocationsViewModel()
    @State private var page: Int = 1 {
        willSet {
            if newValue < 0 {
                page = 1
            }
        }
    }
    @State private var subscribers = Set<AnyCancellable>()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            List {
                Section {
                    FormLocationView(location: $seeAllLocationsViewModel.selectedLocation)
                } header: {
                    HStack {
                        Text("UPDATE LOCATION")
                        Spacer()
                        Button(action: {
                            updateLocation()
                        }, label: {
                            Image(systemName: "arrow.counterclockwise")
                        })
                    }
                }
                
                Section {
                    ForEach(seeAllLocationsViewModel.locations) { location in
                        HStack {
                            Text(location.locationName)
                        }
                        .task {
                            if location == seeAllLocationsViewModel.locations.last {
                                page += 1
                                getLocations()
                            }
                        }
                        .onTapGesture {
                            seeAllLocationsViewModel.selectedLocation = location
                            
                        }
                    }
                    .onDelete(perform: { indexSet in
                        let index = indexSet[indexSet.startIndex]
                        let locationToDelete = seeAllLocationsViewModel.locations[index]
                        deleteLocation(location: locationToDelete)
                        
                    })
                } header: {
                    HStack {
                        Text("Locations")
                    }
                }
            }
            .disabled(isLoading)
            if isLoading {
                ProgressView()
            }
        }
        .onAppear() {
            getLocations()
        }
    }
    
    func getLocations() {
        self.isLoading = true
        seeAllLocationsViewModel.locationService
            .getLocations(page: String(page), limit: "20")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                value.data.data.forEach { newLocation in
                    if !seeAllLocationsViewModel.locations.contains(where: {
                        newLocation.id == $0.id
                    }) {
                        seeAllLocationsViewModel.locations.append(newLocation)
                    }
                }
            })
            .store(in: &subscribers)
    }
    
    func updateLocation() {
        guard let location = seeAllLocationsViewModel.selectedLocation else { return }
        self.isLoading = true
        seeAllLocationsViewModel.locationService
            .updateLocation(location: location)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                print("value", value)
            })
            .store(in: &subscribers)
    }
    
    func deleteLocation(location: Location) {
        self.isLoading = true
        seeAllLocationsViewModel.locationService
            .deleteLocation(id: location.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                    seeAllLocationsViewModel.locations.removeAll(where: { $0.id == location.id })
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                self.isLoading = value
            })
            .store(in: &subscribers)
    }
}

#Preview {
    SeeAllLocationsView()
}
