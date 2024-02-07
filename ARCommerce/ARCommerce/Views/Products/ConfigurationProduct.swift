//
//  ConfigurationProduct.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI
import Combine

struct ConfigurationProduct: View {    
    @State private var isAddButtonEnabled = true
    
    @Binding var selectedConfig: Int
    @Binding var listConfigurations: [ProductConfig]
    @State var showImagePicker = false
    
    @State var productDescription = ""
    
    @State private var refreshID = UUID()
    var body: some View {
        VStack {
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
                TextField("Description", text: $listConfigurations[selectedConfig].productDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Price", text: $listConfigurations[selectedConfig].priceText)
                    .keyboardType(.numberPad)
                    .onChange(of: listConfigurations[selectedConfig].priceText) { _,newInput in
                        let filtered = newInput.filter { "0123456789.".contains($0) }
                        if (Double(filtered) != nil) {
                            listConfigurations[selectedConfig].price = Double(newInput) ?? 0
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("Cost Price", text: $listConfigurations[selectedConfig].productionPriceText)
                    .keyboardType(.numberPad)
                    .onChange(of: listConfigurations[selectedConfig].productionPriceText) { _,newInput in
                        let filtered = newInput.filter { "0123456789.".contains($0) }
                        if (Double(filtered) != nil) {
                            listConfigurations[selectedConfig].productionPrice = Double(newInput) ?? 0
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ColorPicker("Select a color", selection: $listConfigurations[selectedConfig].selectedColor)
                    .onChange(of: listConfigurations[selectedConfig].selectedColor) { _,newValue in
                        listConfigurations[selectedConfig].colorHex = newValue.toHex()
                    }
                    .padding()
            }
            
            
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePicker() { pickedImage in
                if let image = pickedImage {
                    listConfigurations[selectedConfig].uimages?.append(image)
                    refreshID = UUID()
                }
            }
        }
    }
}

//#Preview {
//    ConfigurationProduct()
//}
