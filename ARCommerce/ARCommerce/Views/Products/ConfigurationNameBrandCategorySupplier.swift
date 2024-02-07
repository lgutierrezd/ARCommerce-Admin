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
    @Binding var selectedCategory: ARCommerce.Category?
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
            
            // Picker for Suppliers
            Picker("Category", selection: $selectedCategory) {
                ForEach(globalDataManagerViewModel.categories, id: \.self) { category in
                    Text(category.name).tag(category as ARCommerce.Category?)
                }
            }
            
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
    
    private func isValidAddProduct() -> Bool {
        if name.isEmpty || name.count < 4 {
            return false
        }
        
        if selectedSuppliers!.count < 1 {
            return false
        }
        
        if selectedCategory == nil {
            return false
        }
        
        if selectedBrand == nil {
            return false
        }
        return true
    }
    
}

#Preview {
    ConfigurationNameBrandCategorySupplier(name: .constant("iphone"), selectedBrand: .constant(Brand(id: "", name: "Apple")), selectedCategory: .constant(Category(_id: "", name: "CellPhones", setup: [Setup(_id: "", key: "", value: "")])), selectedSuppliers: .constant([Supplier(id: "", name: "iCON", email: "icon@icon.com", phone: "88888888")]))
}
