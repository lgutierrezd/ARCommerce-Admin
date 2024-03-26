//
//  StockConfigureView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI
import Combine
//
//struct StockConfigureView: View {
//    @State private var locations: [Location] = []
//    
//    @Binding var selectedConfig: Int
//    @Binding var listConfigurations: [ProductConfig]
//    
//    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
//    
//    @State private var cancellables: [AnyCancellable] = []
//    
//    init(selectedConfig: Binding<Int>, listConfigurations: Binding<[ProductConfig]>) {
//        _selectedConfig = selectedConfig
//        _listConfigurations = listConfigurations
//    }
//    
//    var body: some View {
//        List {
//            Section {
//                if listConfigurations[selectedConfig].stock.count > 0 && !locations.isEmpty  {
//                    ForEach(0..<listConfigurations[selectedConfig].stock.count, id: \.self) { index in
//                        VStack {
//                            HStack {
//                                Picker("Select a location", selection: $listConfigurations[selectedConfig].stock[index].location) {
//                                    ForEach(locations, id: \.self) {
//                                        Text("\($0.locationName)").tag($0)
//                                    }
//                                }
//                                .pickerStyle(.navigationLink)
//                            }
//                            HStack {
//                                TextField("Quantity", text: $listConfigurations[selectedConfig].stock[index].quantityText)
//                                    .onAppear {
//                                        // Set the placeholder text initially
//                                        if listConfigurations[selectedConfig].stock[index].quantityText.isEmpty {
//                                            listConfigurations[selectedConfig].stock[index].quantityText = "\(listConfigurations[selectedConfig].stock[index].quantity)"
//                                        }
//                                    }
//                                    .onChange(of: listConfigurations[selectedConfig].stock[index].quantityText) { _,newValue in
//                                        // Update the quantity when the text changes
//                                        if let newValue = Int(newValue) {
//                                            listConfigurations[selectedConfig].stock[index].quantity = newValue
//                                        }
//                                    }
//                                TextField("Size", text: $listConfigurations[selectedConfig].stock[index].size)
//                            }
//                        }
//                    }
//                    
//                }
//            } header: {
//                HStack {
//                    Text("Configuration Stock")
//                    Spacer()
//                    Button {
//                        if listConfigurations[selectedConfig].stock.count > 0 {
//                            let _ = listConfigurations[selectedConfig].stock.popLast()
//                        }
//                    } label: {
//                        Image(systemName: "minus")
//                    }
//                    .disabled(listConfigurations[selectedConfig].stock.count < 1)
//                    Button {
//                        if let location = globalDataManagerViewModel.locations.first {
//                            listConfigurations[selectedConfig].stock.append(Stock(location: location, quantity: 0, size: ""))
//                        }
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//        }
//        .onAppear() {
//            globalDataManagerViewModel.locations.publisher.sink { newValue in  
//                if locations.isEmpty || locations.contains(where: { $0._id == newValue._id }) {
//                    self.locations.removeAll()
//                    self.locations = globalDataManagerViewModel.locations
////                    locations.append(newValue)
//                }
//                
//            }
//            .store(in: &cancellables)
//        }
//    }
//}
//
