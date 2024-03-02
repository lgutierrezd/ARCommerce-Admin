//
//  StockConfigureView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct StockConfigureView: View {
    let isUpdate: Bool
    @State private var uuid = UUID()
    @State private var stocks: [Stock] = []
    @State private var locations: [Location] = []
    @State private var numberOfStocks: Int = 0
    
    @Binding var selectedConfig: Int
    @Binding var listConfigurations: [ProductConfig]
    
    @StateObject var seeAllLocationsViewModel = SeeAllLocationsViewModel()
    
    init(isUpdate: Bool, selectedConfig: Binding<Int>, listConfigurations: Binding<[ProductConfig]>) {
        self.isUpdate = isUpdate
        _selectedConfig = selectedConfig
        _listConfigurations = listConfigurations
    }
    
    var body: some View {
        List {
            Section {
                if numberOfStocks > 0 && !locations.isEmpty  {
                    ForEach(0..<numberOfStocks, id: \.self) { index in
                        VStack {
                            HStack {
                                Picker(selection: $locations[index], label: Text("Select a location")) {
                                    ForEach(seeAllLocationsViewModel.locations, id: \.self) { location in
                                        Text(location.locationName).tag(location._id)
                                    }
                                }
                            }
                            HStack {
                                TextField("Quantity", text: $stocks[index].quantityText)
                                    .onAppear {
                                        // Set the placeholder text initially
                                        if stocks[index].quantityText.isEmpty {
                                            stocks[index].quantityText = "\(stocks[index].quantity)"
                                        }
                                    }
                                    .onChange(of: stocks[index].quantityText) { _,newValue in
                                        // Update the quantity when the text changes
                                        if let newValue = Int(newValue) {
                                            stocks[index].quantity = newValue
                                        }
                                    }
                                TextField("Size", text: $stocks[index].size)
                            }
                        }
                        
                    }
                    
                }
            } header: {
                HStack {
                    Text("Configuration Stock")
                    Spacer()
                    Button {
                        if numberOfStocks > 0 {
                            //let _ = self.listConfigurations[selectedConfig].stock.popLast()
                            let _ = stocks.popLast()
                            let _ = locations.popLast()
                            numberOfStocks -= 1
                            uuid = UUID()
                        }
                        
                    } label: {
                        Image(systemName: "minus")
                    }
                    .disabled(numberOfStocks < 1)
                    Button {
                        if let location = seeAllLocationsViewModel.locations.first {
                            stocks.append(Stock(location: location, quantity: 0, size: ""))
                            locations.append(location)
                        }
                        numberOfStocks += 1
                        uuid = UUID()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
        }.id(uuid)
        .onAppear() {
            self.locations.removeAll()
            self.stocks.removeAll()
            numberOfStocks = 0
            Task {
                do {
                    try await seeAllLocationsViewModel.getAllLocations()
                    
                    
                    for stock in listConfigurations[selectedConfig].stock {
                        self.stocks.append(stock)
                        if let location = seeAllLocationsViewModel.locations.first(where: {$0._id == stock.location._id }) {
                            self.locations.append(location)
                        }
                    }
                    uuid = UUID()
                    numberOfStocks = self.stocks.count
                } catch {
                    
                }
            }
            
            
        }
        .onDisappear() {
            for (index, location) in locations.enumerated() {
                self.stocks[index].location = location
            }
            
            listConfigurations[selectedConfig].stock = self.stocks
        }
    }
}

