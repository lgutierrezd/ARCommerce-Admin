//
//  ConfigurationNameBrandCategorySupplier.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct ConfigurationNameBrandCategorySupplier: View {
    @Binding var name: String
    @Binding var selectedBrand: Brand?
    @Binding var selectedCategories: Set<String>
    @Binding var selectedSuppliers: Set<Supplier>?
    
    @State private var isSuppliersSectionExpanded: Bool = true
    
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    
    var body: some View {
        List {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            // Picker for Brands
            Picker("Brand", selection: $selectedBrand) {
                ForEach(globalDataManagerViewModel.brands, id: \.self) { brand in
                    Text(brand.name).tag(brand as Brand?)
                }
            }
            
            NavigationLink(
                destination: {
                    SelectCategoriesView(selectedItems: $selectedCategories, categories: globalDataManagerViewModel.categories)
                }, label: {
                    Text("Categories")
                })
            
            
            // Picker for Categories
            DisclosureGroup("Suppliers", isExpanded: $isSuppliersSectionExpanded) {
                ForEach(globalDataManagerViewModel.suppliers, id: \.self) { supplier in
                    Toggle(isOn: Binding(
                        get: { selectedSuppliers!.contains(supplier) },
                        set: { newValue in
                            if newValue {
                                selectedSuppliers?.insert(supplier)
                            } else {
                                selectedSuppliers?.remove(supplier)
                            }
                        }
                    )) {
                        Text(supplier.name)
                    }
                }
            }
        }
    }
    
}

//#Preview {
//    ConfigurationNameBrandCategorySupplier(name: .constant("iphone"), selectedBrand: .constant(Brand(id: "", name: "Apple")), selectedCategory: .constant(Category(_id: "", name: "CellPhones", setup: [Setup(_id: "", key: "", value: "")])), selectedSuppliers: .constant([Supplier(id: "", name: "iCON", email: "icon@icon.com", phone: "88888888")]))
//}
