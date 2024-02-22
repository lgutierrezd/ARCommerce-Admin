//
//  SeeAllLocationsView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct SeeAllLocationsView: View {
    @StateObject var seeAllLocationsViewModel = SeeAllLocationsViewModel()
    @State private var page: Int = 1 {
        willSet {
            if newValue < 0 {
                page = 1
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                FormLocationView(locationName: $seeAllLocationsViewModel.locationName, lat: $seeAllLocationsViewModel.lat, lon: $seeAllLocationsViewModel.lon)
            } header: {
                HStack {
                    Text("UPDATE LOCATION")
                    Spacer()
                    Button(action: {
                        Task {
                            do {
                                let _ = try await seeAllLocationsViewModel.updateLocation()
                            } catch {
                                
                            }
                        }
                        
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
                    .onTapGesture {
                        seeAllLocationsViewModel.id = location._id
                        seeAllLocationsViewModel.locationName = location.locationName
                        seeAllLocationsViewModel.lat = location.lat
                        seeAllLocationsViewModel.lon = location.lon
                    }
                }
                .onDelete(perform: { indexSet in
                    let index = indexSet[indexSet.startIndex]
                    let locationToDelete = seeAllLocationsViewModel.locations[index]
                    Task {
                        do {
                            let _ = try await seeAllLocationsViewModel.deleteLocation(location: locationToDelete)
                        } catch {
                            
                        }
                        
                    }
                    
                })
            } header: {
                HStack {
                    Spacer()
                    Button(action: {
                        page -= 1
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                    .disabled(page == 1 ? true : false)
                    Button(action: {
                        page += 1
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                    })
                    .disabled(seeAllLocationsViewModel.locations.count < 8)
                }
            }
        }
        .onAppear() {
            Task {
                do {
                    try await seeAllLocationsViewModel.getAllLocations()
                } catch {
                    
                }
            }
            
        }
    }
}

#Preview {
    SeeAllLocationsView()
}
