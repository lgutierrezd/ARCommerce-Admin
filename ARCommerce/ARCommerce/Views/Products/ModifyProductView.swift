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
                let productToUpdate = Product(id: selectedProduct.id, name: selectedProduct.name, slug: selectedProduct.slug, isActive: selectedProduct.isActive, categories: selectedProduct.categories.map{ $0._id }, brand: selectedProduct.brand.id, suppliers: selectedProduct.suppliers)
                
                AddAndUpdateProductView(product: productToUpdate, isUpdate: true, name: selectedProduct.name, selectedBrand: [selectedProduct.brand.id], selectedCategories: Set(selectedProduct.categories.compactMap({$0._id})), selectedSuppliers: Set(selectedProduct.suppliers))
            }
       
        }

    }
}

#Preview {
    ModifyProductView()
}
