//
//  ModifyProductView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftUI

struct ModifyProductView: View {
    @ObservedObject private var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    
    var body: some View {
        VStack {
            if let selectedProduct = globalDataManagerViewModel.selectedProduct {
                let suppliers = globalDataManagerViewModel.suppliers.filter { s in
                    selectedProduct.suppliers.contains(where: { id in
                        id == s.id
                    })
                }
                
                
                //AddAndUpdateProductView(product: product, isUpdate: true, name: selectedProduct.name, selectedBrand: brand,selectedCategory: <#T##Category?#> selectedSuppliers: Set(suppliers), selectedCategories: Set(selectedProduct.categories.map({$0._id})))
                
                AddAndUpdateProductView(product: selectedProduct, isUpdate: true, name: selectedProduct.name, selectedBrand: selectedProduct.brand, selectedCategories: Set(selectedProduct.categories.compactMap({$0._id})), selectedSuppliers: Set(suppliers))
            }
       
        }

    }
}

#Preview {
    ModifyProductView()
}
