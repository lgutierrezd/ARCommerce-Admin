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
                let product = Product(id: selectedProduct._id, name: selectedProduct.name, slug: selectedProduct.slug, isActive: selectedProduct.isActive, category: selectedProduct.category._id, brand: selectedProduct.brand.id, suppliers: selectedProduct.suppliers)
                let brand = globalDataManagerViewModel.brands.first(where: { $0.id == selectedProduct.brand.id })
                let category = globalDataManagerViewModel.categories.first(where: { $0._id == selectedProduct.category._id })
                let suppliers = globalDataManagerViewModel.suppliers.filter { s in
                    selectedProduct.suppliers.contains(where: { id in
                        id == s.id
                    })
                }
                
                
                AddAndUpdateProductView(product: product, isUpdate: true, name: selectedProduct.name, selectedBrand: brand, selectedCategory: category, selectedSuppliers: Set(suppliers))
            }
       
        }

    }
}

#Preview {
    ModifyProductView()
}
