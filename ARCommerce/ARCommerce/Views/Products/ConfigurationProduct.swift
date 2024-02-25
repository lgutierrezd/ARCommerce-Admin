//
//  ConfigurationProduct.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI
import Combine

struct ConfigurationProduct: View {
    let isUpdate: Bool
    @Binding var selectedConfig: Int
    @Binding var listConfigurations: [ProductConfig]
    @Binding var selectedType: String
    
    private var types = ["color", "size", "weight", "food"]
    
    init(isUpdate: Bool, selectedConfig: Binding<Int>, listConfigurations: Binding<[ProductConfig]>, selectedType: Binding<String>) {
        self.isUpdate = isUpdate
         _selectedConfig = selectedConfig
         _listConfigurations = listConfigurations
         _selectedType = selectedType
     }
    
    var body: some View {
        List {
            Picker(selection: $selectedConfig, label: Text("Select a configuration")) {
                ForEach(0..<listConfigurations.count, id: \.self) { id in
                    HStack {
                        Spacer()
                        Text("Configuration \(id + 1)")
                    }
                    .accentColor(selectedConfig == id ? .buttonSelected : .accentColor)
                    .bold(selectedConfig == id)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            if listConfigurations.count > 0 {
                Picker("Select Type", selection: $selectedType) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                switch selectedType {
                case "color":
                    ColorPicker("Select a color", selection: $listConfigurations[selectedConfig].selectedColor)
                        .onChange(of: listConfigurations[selectedConfig].selectedColor) { _,newValue in
                            listConfigurations[selectedConfig].colorHex = newValue.toHex()
                        }
                    
                case "size":
                    HStack {
                        Text("Size:")
                            .frame(width: 100)
                        TextField("Size", text: $listConfigurations[selectedConfig].size)
                    }
                    
                case "weight":
                    HStack {
                        Text("Weight:")
                            .frame(width: 100)
                        TextField("Weight", text: $listConfigurations[selectedConfig].weight)
                    }
                    
                default:
                    HStack {
                        Text("Food:")
                        Spacer()
                    }
                }
                HStack {
                    Text("Description:")
                        .frame(width: 100)
                    TextField("Description", text: $listConfigurations[selectedConfig].productDescription)
                }
                HStack {
                    Text("Price:")
                        .frame(width: 100)
                    TextField("Price", text: $listConfigurations[selectedConfig].priceText)
                        .keyboardType(.numberPad)
                        .onChange(of: listConfigurations[selectedConfig].priceText) { _,newInput in
                            let filtered = newInput.filter { "0123456789.".contains($0) }
                            if (Double(filtered) != nil) {
                                listConfigurations[selectedConfig].price = Double(newInput) ?? 0
                            }
                        }
                    
                }
                HStack {
                    Text("Discount:")
                        .frame(width: 100)
                    TextField("Discount Price", text: $listConfigurations[selectedConfig].discountPriceText)
                        .keyboardType(.numberPad)
                        .onChange(of: listConfigurations[selectedConfig].discountPriceText) { _,newInput in
                            let filtered = newInput.filter { "0123456789.".contains($0) }
                            if (Double(filtered) != nil) {
                                listConfigurations[selectedConfig].discountPrice = Double(newInput) ?? 0
                            }
                        }
                }
                HStack {
                    Text("Cost Price:")
                        .frame(width: 100)
                    TextField("Cost Price", text: $listConfigurations[selectedConfig].productionPriceText)
                        .keyboardType(.numberPad)
                        .onChange(of: listConfigurations[selectedConfig].productionPriceText) { _,newInput in
                            let filtered = newInput.filter { "0123456789.".contains($0) }
                            if (Double(filtered) != nil) {
                                listConfigurations[selectedConfig].productionPrice = Double(newInput) ?? 0
                            }
                        }
                }
                NavigationLink(
                    destination: {
                        StockConfigureView(isUpdate: self.isUpdate, selectedConfig: $selectedConfig, listConfigurations: $listConfigurations)
                    }, label: {
                        Text("Set up Stocks")
                    }
                )
            }
        }
        .onDisappear() {
            if !listConfigurations.isEmpty {
                listConfigurations[selectedConfig].type = selectedType
            }
        }
    }
}

//#Preview {
//    ConfigurationProduct()
//}
