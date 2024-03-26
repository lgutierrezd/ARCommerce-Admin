//
//  SeeAllProducts.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 13/1/24.
//

import SwiftUI
//
//struct SeeAllProductsView: View {
//    @StateObject private var seeAllProductsViewModel = SeeAllProductsViewModel()
//    @State private var page = 1 {
//        willSet {
//            if newValue < 1 {
//                page = 1
//            }
//        }
//    }
//    @State private var indicesToRemove: IndexSet?
//    @State private var getActives: Bool = true
//    @State private var refreshID = UUID()
//    
//    @State private var showAlertModifyProduct = false
//    @State private var selectedProduct: ProductV1?
//    
//    @ObservedObject private var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
//    var body: some View {
//        VStack {
//            List {
//                Section {
//                    ForEach(seeAllProductsViewModel.products.filter({ $0.isActive == getActives }), id: \.id) { product in
//                        if !getActives {
//                            HStack {
//                                Text(product.name)
//                            }
//                            .swipeActions {
//                                Button("Activate") {
//                                    activateProduct(product)
//                                }
//                                .tint(.green)
//                            }
//                        } else {
//                            HStack {
//                                Text(product.name)
//                            }
//                            .onTapGesture {
//                                self.showAlertModifyProduct = true
//                                self.selectedProduct = product
//                            }
//                        }
//                        
//                    }
//                    .onDelete(perform: getActives ? removeProducts : nil)
//                    .id(refreshID)
//                    
//                } header: {
//                    VStack {
//                        Toggle(isOn: $getActives, label: {
//                            Text("Actives")
//                        })
//                    }
//                }
//                .alert(isPresented: $showAlertModifyProduct) {
//                    Alert(title: Text("Would you like to modify this product?"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Accept"), action: {
//                        globalDataManagerViewModel.selectedProduct = self.selectedProduct
//                        globalDataManagerViewModel.selectedItem = MenuViewModel.menuItem(for: 1, itemID: 1)
//                    }), secondaryButton: .cancel())
//                }
//            }
//            HStack {
//                Button {
//                    page -= 1
//                    getAllProducts()
//                } label: {
//                    Text("Atras")
//                }
//                Spacer()
//                
//                Button {
//                    page += 1
//                    getAllProducts()
//                } label: {
//                    Text("Siguiente")
//                }
//            }
//            .padding()
//        }
//        .onAppear() {
//            getAllProducts()
//            
//        }
//        
//    }
//    
//    fileprivate func removeProducts(at offsets: IndexSet) {
//        let productsFiltered = seeAllProductsViewModel.products.filter({ $0.isActive == getActives })
//        
//        let index = offsets[offsets.startIndex]
//        let productToDelete = productsFiltered[index]
//        
//        Task {
////            let removed = try await seeAllProductsViewModel.deleteProducts(products: [productToDelete])
////            
////            removed.forEach { productsToRemove in
////                let product =  productsToRemove.0
////                if let index = seeAllProductsViewModel.products.firstIndex(where: { $0.id == product.id }) {
////                    seeAllProductsViewModel.products[index].isActive.toggle()
////                }
////                refreshID = UUID()
////            }
//        }
//    }
//    
//    fileprivate func activateProduct(_ product: ProductV1) {
//        Task {
//            do {
////                let isActive = try await seeAllProductsViewModel.activateProduct(product: product)
////                if isActive {
////                    if let index = seeAllProductsViewModel.products.firstIndex(where: { $0.id == product.id }) {
////                        seeAllProductsViewModel.products[index].isActive = true
////                    }
////                    refreshID = UUID()
////                }
//            } catch {
//                
//            }
//            
//        }
//    }
//    
//    fileprivate func getAllProducts() {
//        Task {
////            try await seeAllProductsViewModel.getAllProducts(page: page)
//        }
//    }
//}
