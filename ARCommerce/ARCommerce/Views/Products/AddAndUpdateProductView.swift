//
//  AddAndUpdateProduct.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct AddAndUpdateProductView: View {
    @State var product: ProductV1?
    
    @State var listConfigurations = [ProductConfig]()
    
    var isUpdate: Bool?
    
    @State var name: String = ""
    
    @State var selectedBrand: Brand?
    @State var selectedCategories: Set<String> = []
    @State var selectedSuppliers: Set<Supplier>? = []
    
    @State private var selectedImagesByConfiguration: [UIImage]?
    @State var showImagePicker = false
    
    @State private var showAlertDeleteConfig = false
    @State private var selectedConfig: Int = -1 {
        didSet {
            if selectedConfig < 0 {
                selectedConfig = 0
            }
        }
    }
    
    @StateObject private var addAndUpdateProductViewModel = AddAndUpdateProductViewModel()
    
    @State private var showAlertAddProduct = false
    @State private var alertText: String = ""
    
    @State private var loading = false
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section {
                        ConfigurationNameBrandCategorySupplier(name: $name, selectedBrand: $selectedBrand, selectedCategories: $selectedCategories, selectedSuppliers: $selectedSuppliers)
                        
                    } header: {
                        Text("Product Definition")
                    }
                    
                    Section {
                        ConfigurationProduct(selectedConfig: $selectedConfig, listConfigurations: $listConfigurations)
                            .onChange(of: selectedConfig) { _,_ in
                                if !listConfigurations.isEmpty {
                                    selectedImagesByConfiguration = listConfigurations[selectedConfig].uimages
                                }
                                
                            }
                    } header: {
                        HStack {
                            Text("Configuration")
                            Spacer()
                            Button {
                                if !(listConfigurations.count < 1) {
                                    self.showAlertDeleteConfig = true
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            Button {
                                let productConfig = ProductConfig(id: "", price: 0, productionPrice: 0, selectedColor: .blue, colorHex: "", images: [], uimages: [], productDescription: "", stock: [], isActive: true, extraConfig: [:])
                                self.listConfigurations.append(productConfig)
                                print("count \(listConfigurations.count)")
                                
                                if listConfigurations.count == 1 {
                                    self.selectedConfig = 0
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        .alert(isPresented: $showAlertDeleteConfig) {
                            Alert(title: Text("Delete configuration selected"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Accept"), action: {
                                self.listConfigurations.remove(at: self.selectedConfig)
                                self.selectedConfig -= 1
                            }), secondaryButton: .cancel())
                        }
                    }
                    
                    Section {
                        if listConfigurations.count > 0 {
                            ConfigurationProductImageView(selectedConfig: $selectedConfig, selectedImagesByConfiguration: $selectedImagesByConfiguration)
                        }
                    } header: {
                        HStack {
                            Text("Image Configuration")
                            Spacer()
                            Button {
                                if listConfigurations[selectedConfig].uimages!.count > 0 {
                                    listConfigurations[selectedConfig].uimages?.removeLast()
                                    selectedImagesByConfiguration = listConfigurations[selectedConfig].uimages
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                            }
                            .disabled(disableAddImage())
                            Button(action: {
                                showImagePicker = true
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                            })
                            .disabled(disableAddImage())
                        }
                    }
                    .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                        ImagePicker() { pickedImage in
                            showImagePicker = false
                            if let image = pickedImage {
                                listConfigurations[selectedConfig].uimages?.append(image)
                                selectedImagesByConfiguration = listConfigurations[selectedConfig].uimages
                            }
                        }
                    }
                }
                
                if loading {
                    VStack {
                        Text("Loading...")
                            .font(.footnote)
                        ProgressView()
                    }
                }
            }
        }
        
        .navigationTitle(isUpdate ?? false ? "Update Product" :"Add Product")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isUpdate ?? false {
                    Button {
                        updateProduct()
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    //.disabled(!isAddButtonEnabled)
                } else {
                    
                    Button {
                        addProduct()
                    } label: {
                        Image(systemName: "plus")
                    }
                    //.disabled(!isAddButtonEnabled)
                }
            }
        }
        .alert(isPresented: $showAlertAddProduct) {
            Alert(title: Text("Error"), message: Text(alertText))
        }
        .onAppear() {
            if isUpdate ?? false {
                Task {
                    loading = true
                    do {
                        self.listConfigurations = try await addAndUpdateProductViewModel.getConfigs(productId: self.product!.id)
                        if self.listConfigurations.count > 0 {
                            self.selectedConfig = 0
                        }
                    } catch {
                        handleError(error)
                        restartViewData()
                    }
                    loading = false
                }
            }
        }
    }
    
    func disableAddImage() -> Bool {
        if listConfigurations.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    private func isValidAddProduct() -> Bool {
        if name.isEmpty || name.count < 4 {
            return false
        }
        
        if selectedSuppliers?.count ?? 0 < 1 {
            return false
        }
        
        if selectedCategories.count < 1 {
            return false
        }
        
        if selectedBrand == nil {
            return false
        }
        return true
    }
    
    private func updateProduct() {
        Task {
            do {
                self.loading = true
                if isValidAddProduct() {
                    if let product = self.product, let brand = selectedBrand, let suppliers = selectedSuppliers  {
                        product.name = name
                        product.brand = brand
                        product.categories = selectedCategories.compactMap({ Category(_id: $0, name: "")})
                        product.suppliers = suppliers.compactMap({$0.id})
                        product.isActive = true //falta componente para esto
                        let _ = try await addAndUpdateProductViewModel.updateProduct(product: product)
                        try await addAndUpdateProductViewModel.updateConfigurations(product: product, listConfiguration: listConfigurations)
                    }
                    Task {
                        restartViewData()
                    }
                    
                }
            } catch {
                handleError(error)
            }
        }
    }
    
    fileprivate func handleError(_ error: Error) {
        if let customError = error as? CustomError {
            switch customError {
            case .credentialError:
                alertText = "An error has occurred, try again."
                showAlertAddProduct = true
            case .internalServerError(let value):
                alertText = value
                showAlertAddProduct = true
            case .notFound:
                alertText = "Product do not exits."
                showAlertAddProduct = true
            case .invalidCase:
                alertText = "Something is going wrong."
                showAlertAddProduct = true
            }
            
        } else {
            print(error.localizedDescription)
        }
        self.loading = false
    }
    
    private func addProduct() {
        Task {
            do {
                self.loading = true
                if isValidAddProduct() {
                    if let product = try await addProductDefinition() {
                        try await addConfigurations(product: ProductV1(_id: product.id, id: product.id, isActive: product.isActive, name: product.name, slug: product.slug))
                    }
                    restartViewData()
                }
                
            } catch {
                handleError(error)
            }
        }
    }
    
    private func addProductDefinition() async throws -> Product? {
        if let brand = selectedBrand, let suppliers = selectedSuppliers  {
           return try await addAndUpdateProductViewModel.addProduct(name: name, brand: brand, categories: selectedCategories, suppliers: suppliers)
        }
        return nil
    }
    
    private func addConfigurations(product: ProductV1) async throws {
        try await addAndUpdateProductViewModel.addConfigurations(product: product, listConfiguration: listConfigurations)
    }
    
    private func searchProductByName(name: String) {
        
    }
    
    private func restartViewData() {
        self.product = nil
        self.listConfigurations.removeAll()
        
        self.name = ""
        //        self.selectedBrand: Brand?
        //        self.selectedCategory: ARCommerce.Category?
        //        self.selectedSuppliers: Set<Supplier>? = []
        
        self.selectedImagesByConfiguration?.removeAll()
        self.selectedConfig = 0
        self.loading = false
    }
}
//
//#Preview {
//    AddAndUpdateProductView(isUpdate: false)
//}
