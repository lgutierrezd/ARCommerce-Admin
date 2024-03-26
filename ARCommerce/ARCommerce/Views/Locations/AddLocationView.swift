//
//  AddLocationView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI
import Combine

struct AddLocationView: View {
    @StateObject private var addLocationViewModel = AddLocationViewModel()
    @State private var subscribers = Set<AnyCancellable>()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    var body: some View {
        ZStack {
            Form {
                Section {
                    FormLocationView(location: $addLocationViewModel.location)
                } header: {
                    HStack {
                        Text("ADD LOCATION")
                        Spacer()
                        Button(action: {
                            guard let location = addLocationViewModel.location else { return }
                            self.isLoading = true
                            addLocationViewModel.locationService
                                .addLocation(location: location)
                                .sink(receiveCompletion: { completion in
                                    switch completion {
                                    case .finished:
                                        self.isLoading = false
                                        addLocationViewModel.location = Location(id: "", locationName: "", lat: "", lon: "")
                                    case .failure(let error):
                                        let (showAlert, alertMessage) = AREErrors.handleError(error)
                                        self.showAlert = showAlert
                                        self.alertMessage = alertMessage
                                    }
                                }, receiveValue: { _ in
                                })
                                .store(in: &subscribers)
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
    //                    .disabled()
                    }

                }
            }
            if isLoading {
                ProgressView()
            }
        }
        
    }
}

#Preview {
    AddLocationView()
}
