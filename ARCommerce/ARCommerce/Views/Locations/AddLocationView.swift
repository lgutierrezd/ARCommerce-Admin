//
//  AddLocationView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct AddLocationView: View {
    @StateObject private var addLocationViewModel = AddLocationViewModel()
    
    var body: some View {
        Form {
            Section {
                FormLocationView(locationName: $addLocationViewModel.locationName, lat: $addLocationViewModel.lat, lon: $addLocationViewModel.lon)
            } header: {
                HStack {
                    Text("ADD LOCATION")
                    Spacer()
                    Button(action: {
                        Task {
                            do {
                                let _ = try await addLocationViewModel.addLocation()
                                addLocationViewModel.locationName = ""
                                addLocationViewModel.lat  = ""
                                addLocationViewModel.lon  = ""
                            } catch {
                                
                            }
                            
                        }
                        
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .disabled(self.addLocationViewModel.locationName.isEmpty ? true: false)
                }

            }
        }
    }
}

#Preview {
    AddLocationView()
}
