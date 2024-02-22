//
//  StockConfigureView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct StockConfigureView: View {
    @State private var uuid = UUID()
    @State private var stocks: [Stock] = []
    @State private var locations: [Location] = []
    @State private var numberOfStocks: Int = 0
    
    @Binding var selectedConfig: Int
    @Binding var listConfigurations: [ProductConfig]
    
    @StateObject var seeAllLocationsViewModel = SeeAllLocationsViewModel()
    
    init(selectedConfig: Binding<Int>, listConfigurations: Binding<[ProductConfig]>) {
        _selectedConfig = selectedConfig
        _listConfigurations = listConfigurations
    }
    
    var body: some View {
        List {
            Section {
                if numberOfStocks > 0  {
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
                        //self.listConfigurations[selectedConfig].stock.append(Stock(location: Location(_id: "", locationName: "", lat: "", lon: ""), quantity: 0, size: ""))
                        stocks.append(Stock(location: Location(_id: "", locationName: "", lat: "", lon: ""), quantity: 0, size: ""))
                        locations.append(Location(_id: "", locationName: "", lat: "", lon: ""))
                        numberOfStocks += 1
                        uuid = UUID()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
        }.id(uuid)
        .onAppear() {
            Task {
                do {
                    try await seeAllLocationsViewModel.getAllLocations()
                } catch {
                    
                }
            }
            
            self.locations = []
            self.stocks = []
            
            for stock in listConfigurations[selectedConfig].stock {
                self.stocks.append(stock)
                self.locations.append(stock.location)
            }
            numberOfStocks = self.stocks.count
        }
        .onDisappear() {
            for (index, location) in locations.enumerated() {
                self.stocks[index].location = location
            }
            
            listConfigurations[selectedConfig].stock = self.stocks
            
            self.locations = []
            self.stocks = []
            numberOfStocks = 0
        }
    }
}
