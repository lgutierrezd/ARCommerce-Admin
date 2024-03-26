//
//  ManageProduct.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/5/24.
//

import SwiftUI

//struct ManageProductView: View {
//    @StateObject private var manageProductViewModel: ManageProductViewModel
//    @State var selectedConfig: Int = 0 {
//        didSet {
//            if selectedConfig < 0 {
//                selectedConfig = 0
//            }
//        }
//    }
//    //VIEW
//    @State var isUpdate = false
//    @State var showImagePicker = false
//    @State var showAlertDeleteConfig = false
//    
//    init(isUpdate: Bool, product: ProductV1?) {
//        self.isUpdate = isUpdate
//        if let product = product {
//            if isUpdate {
//                let viewModel = ManageProductViewModel(isUpdate: isUpdate, product: product, selectedBrand: [], selectedCategories: [], selectedSuppliers: [])
//                if let brand = product.brand {
//                    viewModel.selectedBrand.insert(brand.id)
//                }
//                product.categories.forEach{ viewModel.selectedCategories.insert($0._id) }
//                product.suppliers.forEach{ viewModel.selectedSuppliers.insert($0) }
//                
//                
//                _manageProductViewModel = StateObject(wrappedValue: viewModel)
//            } else {
//                let viewModel = ManageProductViewModel(isUpdate: isUpdate, product: ProductV1(_id: "", id: "", isActive: true, name: "", slug: ""), selectedBrand: [], selectedCategories: [], selectedSuppliers: [])
//                _manageProductViewModel = StateObject(wrappedValue: viewModel)
//            }
//        } else {
//            let viewModel = ManageProductViewModel(isUpdate: isUpdate, product: ProductV1(_id: "", id: "", isActive: true, name: "", slug: ""), selectedBrand: [], selectedCategories: [], selectedSuppliers: [])
//            _manageProductViewModel = StateObject(wrappedValue: viewModel)
//        }
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Form {
//                    Section {
//                        ProductView(manageProductViewModel: manageProductViewModel)
//                    } header: {
//                        Text("Product Definition")
//                    }
//                    
//                    Section {
//                        ProductConfigurationView(manageProductViewModel: manageProductViewModel, selectedConfig: $selectedConfig)
//                    } header: {
//                        HStack {
//                            Text("Configuration")
//                            Spacer()
//                            Button {
//                                if !(manageProductViewModel.listConfigurations.count < 1) {
//                                    self.showAlertDeleteConfig = true
//                                }
//                            } label: {
//                                Image(systemName: "minus")
//                            }
//                            Button {
//                                addConfiguration()
//                            } label: {
//                                Image(systemName: "plus")
//                            }
//                        }
//                        .alert(isPresented: $showAlertDeleteConfig) {
//                            Alert(title: Text("Delete configuration selected"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Accept"), action: {
//                                self.manageProductViewModel.listConfigurations.remove(at: self.selectedConfig)
//                                self.selectedConfig -= 1
//                            }), secondaryButton: .cancel())
//                        }
//                    }
//                    
//                    
//                    Section {
//                        ConfigurationProductImageView(manageProductViewModel: manageProductViewModel, selectedConfig: $selectedConfig)
//                    } header: {
//                        HStack {
//                            Text("Image Configuration")
//                            Spacer()
//                            Button {
//                                self.manageProductViewModel.isLoading = true
//                                if manageProductViewModel.listConfigurations[selectedConfig].uimages.count > 0 {
//                                    manageProductViewModel.listConfigurations[selectedConfig].uimages.removeLast()
//                                    manageProductViewModel.listConfigurations[selectedConfig].images.removeLast()
//                                    let indexToDelete = manageProductViewModel.listConfigurations[selectedConfig].images.count
//                                    if isUpdate {
//                                        Task {
//                                            await FirebaseStorage.deleteFileFromFirebase(filePath: "\(manageProductViewModel.product.id)/\(selectedConfig)/\(manageProductViewModel.product.id)-\(indexToDelete).jpg")
//                                            self.manageProductViewModel.isLoading = false
//                                            
//                                        }
//                                        Task {
//                                            try? await self.manageProductViewModel.updateProductConfiguration()
//                                        }
//                                        
//                                    }
//                                }
//                            } label: {
//                                Image(systemName: "minus")
//                            }
////                            .disabled(disableAddImage())
//                            Button(action: {
//                                showImagePicker = true
//                            }, label: {
//                                Image(systemName: "plus")
//                            })
////                            .disabled(disableAddImage())
//                        }
//                    }
//                    .disabled(manageProductViewModel.isLoading)
//                    
//                }
//                
//                if manageProductViewModel.isLoading {
//                    VStack {
//                        ProgressView()
//                    }
//                }
//            }
//        }
//        .navigationTitle(isUpdate ? "Update Product" :"Add Product")
//        .navigationBarTitleDisplayMode(.large)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                if isUpdate {
//                    Button {
//                        Task {
//                            try? await manageProductViewModel.updateProduct()
//                        }
//                    } label: {
//                        Image(systemName: "arrow.counterclockwise")
//                    }
//                    .disabled(manageProductViewModel.isLoading)
//                } else {
//                    
//                    Button {
//                        Task {
//                            try? await  manageProductViewModel.addProduct()
//                        }
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                    .disabled(manageProductViewModel.isLoading)
//                }
//            }
//        }
//        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
//            ImagePicker() { pickedImage in
//                showImagePicker = false
//                if let image = pickedImage {
//                    manageProductViewModel.listConfigurations[selectedConfig].uimages.append(image)
//                    if isUpdate {
//                        Task {
//                            self.manageProductViewModel.isLoading = true
//                            if let urlDownload = try? await FirebaseStorage.persistImageToStorage(
//                                path:"\(manageProductViewModel.product.id)/\(selectedConfig)/",
//                                name:"\(manageProductViewModel.product.id)-\(manageProductViewModel.listConfigurations[selectedConfig].uimages.count - 1).jpg",
//                                image:image) {
//                                manageProductViewModel.listConfigurations[selectedConfig].images.append(urlDownload)
//                                try? await self.manageProductViewModel.updateProductConfiguration()
//                            }
//                            self.manageProductViewModel.isLoading = false
//                        }
//                    }
//                    
//                }
//            }
//        }
//        .alert(isPresented: $manageProductViewModel.showAlert) {
//            Alert(title: Text("Error"), message: Text(manageProductViewModel.alertText))
//        }
//    }
//    
//    private func addConfiguration() {
//        let productConfig = ProductConfig(id: "", price: 0, discountPrice: 0, productionPrice: 0, type: "color", selectedColor: .white, colorHex: "#ffffff", size: "", weight: "", images: [], productDescription: "", stock: [] ,isActive: true)
//        
//        self.manageProductViewModel.listConfigurations.append(productConfig)
//        
//        if manageProductViewModel.listConfigurations.count == 1 {
//            self.selectedConfig = 0
//        }
//    }
//}
//
//#Preview {
//    ManageProductView(isUpdate: false, product: nil)
//}
