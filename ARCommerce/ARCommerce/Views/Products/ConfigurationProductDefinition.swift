//
//  ConfigurationNameBrandCategorySupplier.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct ConfigurationProductDefinition: View {
    @Binding var name: String
    @Binding var selectedBrand: Set<String>
    @Binding var selectedCategories: Set<String>
    @Binding var selectedSuppliers: Set<String>
    @Binding var active: Bool
    
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    
    var body: some View {
        List {
            TextField("Name", text: $name)
            NavigationLink(
                destination: {
                    SelectBrandView(selectedBrand: $selectedBrand, brands: globalDataManagerViewModel.brands)
                }, label: {
                    Text("Brands")
                }
            )
            
            NavigationLink(
                destination: {
                    SelectCategoriesView(selectedItems: $selectedCategories, categories: globalDataManagerViewModel.categories)
                }, label: {
                    Text("Categories")
                }
            )
            
            NavigationLink(
                destination: {
                    SelectSuppliersView(selectedItems: $selectedSuppliers, suppliers: globalDataManagerViewModel.suppliers)
                }, label: {
                    Text("Suppliers")
                }
            )
            
            Toggle("Active", isOn: $active)
        }
        .onAppear() {
            do {
                try globalDataManagerViewModel.getInitialData()
            } catch {
                
            }
            
        }
    }
    
}

//#Preview {
//    ConfigurationNameBrandCategorySupplier(name: .constant("iphone"), selectedBrand: .constant(Brand(id: "", name: "Apple")), selectedCategory: .constant(Category(_id: "", name: "CellPhones", setup: [Setup(_id: "", key: "", value: "")])), selectedSuppliers: .constant([Supplier(id: "", name: "iCON", email: "icon@icon.com", phone: "88888888")]))
//}
