//
//  ProductConfigurationView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/5/24.
//

import SwiftUI

//struct ProductConfigurationView: View {
//    private var types = ["color", "size", "weight", "food"]
//    @ObservedObject private var manageProductViewModel: ManageProductViewModel
//    @Binding var selectedConfig: Int
//    
//    init(manageProductViewModel: ManageProductViewModel, selectedConfig: Binding<Int>) {
//        self.manageProductViewModel = manageProductViewModel
//        self._selectedConfig = selectedConfig
//    }
//    
//    var body: some View {
//        List {
//            Picker(selection: $selectedConfig, label: Text("Select a configuration")) {
//                ForEach(0..<manageProductViewModel.listConfigurations.count, id: \.self) { id in
//                    HStack {
//                        Spacer()
//                        Text("Configuration \(id + 1)")
//                    }
//                    .accentColor(selectedConfig == id ? .buttonSelected : .accentColor)
//                    .bold(selectedConfig == id)
//                }
//            }
//            .pickerStyle(MenuPickerStyle())
//            
//            if manageProductViewModel.listConfigurations.count > 0 {
//                Picker("Select Type", selection: $manageProductViewModel.listConfigurations[selectedConfig].type) {
//                    ForEach(types, id: \.self) { type in
//                        Text(type)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                switch manageProductViewModel.listConfigurations[selectedConfig].type {
//                case "color":
//                    ColorPicker("Select a color", selection: $manageProductViewModel.listConfigurations[selectedConfig].selectedColor)
//                        .onChange(of: manageProductViewModel.listConfigurations[selectedConfig].selectedColor) { _,newValue in
//                            manageProductViewModel.listConfigurations[selectedConfig].colorHex = newValue.toHex()
//                        }
//                    
//                case "size":
//                    HStack {
//                        Text("Size:")
//                            .frame(width: 100)
//                        TextField("Size", text: $manageProductViewModel.listConfigurations[selectedConfig].size)
//                    }
//                    
//                case "weight":
//                    HStack {
//                        Text("Weight:")
//                            .frame(width: 100)
//                        TextField("Weight", text: $manageProductViewModel.listConfigurations[selectedConfig].weight)
//                    }
//                    
//                default:
//                    HStack {
//                        Text("Food:")
//                        Spacer()
//                    }
//                }
//                HStack {
//                    Text("Description:")
//                        .frame(width: 100)
//                    TextField("Description", text: $manageProductViewModel.listConfigurations[selectedConfig].productDescription)
//                }
//                HStack {
//                    Text("Price:")
//                        .frame(width: 100)
//                    TextField("Price", text: $manageProductViewModel.listConfigurations[selectedConfig].priceText)
//                        .keyboardType(.numberPad)
//                        .onChange(of: manageProductViewModel.listConfigurations[selectedConfig].priceText) { _,newInput in
//                            let filtered = newInput.filter { "0123456789.".contains($0) }
//                            if (Double(filtered) != nil) {
//                                manageProductViewModel.listConfigurations[selectedConfig].price = Double(newInput) ?? 0
//                            }
//                        }
//                    
//                }
//                HStack {
//                    Text("Discount:")
//                        .frame(width: 100)
//                    TextField("Discount Price", text: $manageProductViewModel.listConfigurations[selectedConfig].discountPriceText)
//                        .keyboardType(.numberPad)
//                        .onChange(of: manageProductViewModel.listConfigurations[selectedConfig].discountPriceText) { _,newInput in
//                            let filtered = newInput.filter { "0123456789.".contains($0) }
//                            if (Double(filtered) != nil) {
//                                manageProductViewModel.listConfigurations[selectedConfig].discountPrice = Double(newInput) ?? 0
//                            }
//                        }
//                }
//                HStack {
//                    Text("Cost Price:")
//                        .frame(width: 100)
//                    TextField("Cost Price", text: $manageProductViewModel.listConfigurations[selectedConfig].productionPriceText)
//                        .keyboardType(.numberPad)
//                        .onChange(of: manageProductViewModel.listConfigurations[selectedConfig].productionPriceText) { _,newInput in
//                            let filtered = newInput.filter { "0123456789.".contains($0) }
//                            if (Double(filtered) != nil) {
//                                manageProductViewModel.listConfigurations[selectedConfig].productionPrice = Double(newInput) ?? 0
//                            }
//                        }
//                }
//                NavigationLink(
//                    destination: {
//                        StockConfigureView(selectedConfig: $selectedConfig, listConfigurations: $manageProductViewModel.listConfigurations)
//                    }, label: {
//                        Text("Set up Stocks")
//                    }
//                )
//            }
//        }
//        .onAppear(){
//            if !self.manageProductViewModel.product.id.isEmpty {
//                if self.manageProductViewModel.hasFetchedData { return }
//                Task {
//                    do {
//                        try? await manageProductViewModel.getConfigs(productId:  self.manageProductViewModel.product.id)
//                        selectedConfig = 0
//                    } catch {
//                        
//                    }
//                    
//                }
//            }
//        }
//    }
//}

//#Preview {
//    ProductConfigurationView(manageProductViewModel: ManageProductViewModel(isUpdate: false, product: ProductV1(_id: "", id: "", isActive: true, name: "", slug: ""), selectedBrand: [], selectedCategories: [], selectedSuppliers: []), selectedConfig: .constant(0))
//}
