//
//  ProductView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/5/24.
//

import SwiftUI

struct ProductView: View {
//    @ObservedObject private var manageProductViewModel: ManageProductViewModel
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
//    
//    init(manageProductViewModel: ManageProductViewModel) {
//        self.manageProductViewModel = manageProductViewModel
//    }
    
    var body: some View {
        List {
//            TextField("Name", text: $manageProductViewModel.product.name)
//            NavigationLink(
//                destination: {
//                    SelectBrandView(selectedBrand: $manageProductViewModel.selectedBrand, brands: globalDataManagerViewModel.brands)
//                }, label: {
//                    Text("Brands")
//                }
//            )
//            
//            NavigationLink(
//                destination: {
//                    SelectCategoriesView(selectedItems: $manageProductViewModel.selectedCategories, categories: globalDataManagerViewModel.categories)
//                }, label: {
//                    Text("Categories")
//                }
//            )
//            
//            NavigationLink(
//                destination: {
//                    SelectSuppliersView(selectedItems: $manageProductViewModel.selectedSuppliers, suppliers: globalDataManagerViewModel.suppliers)
//                }, label: {
//                    Text("Suppliers")
//                }
//            )
//            
//            Toggle("Active", isOn: $manageProductViewModel.product.isActive)
        }
        .onAppear() {
            do {
//                try globalDataManagerViewModel.getInitialData()
            } catch {
                
            }
            
        }
    }
}

//#Preview {
//    
//    ProductView(manageProductViewModel: ManageProductViewModel(isUpdate: false, product: ProductV1(_id: "", id: "", isActive: true, name: "", slug: ""), selectedBrand: [], selectedCategories: [], selectedSuppliers: []))
//}
