//
//  AddAndUpdateProduct.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct AddAndUpdateProductView: View {
    @StateObject private var addAndUpdateProductViewModel = AddAndUpdateProductViewModel()
    @State var product: Product
    let isUpdate: Bool
    
    //VIEW
    @State var showImagePicker = false
    @State private var showAlertDeleteConfig = false
    @State private var loading = false
    @State private var showAlertAddProduct = false
    @State private var alertText: String = ""
    
    //ConfigurationProductDefinition
    @State var name: String = ""
    @State var selectedBrand: Set<String> = []
    @State var selectedCategories: Set<String> = []
    @State var selectedSuppliers: Set<String> = []
    @State var active: Bool = true
    
    //ConfigurationProduct
    //StockConfigureView
    @State private var selectedConfig: Int = -1 {
        didSet {
            if selectedConfig < 0 {
                selectedConfig = 0
            }
        }
    }
    @State var listConfigurations = [ProductConfig]()
    @State private var selectedType = "color" //ConfigurationProduct
    
    //ConfigurationProductImageView
    @State private var selectedImagesByConfiguration: [UIImage]?

    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section {
                        ConfigurationProductDefinition(name: $name, selectedBrand: $selectedBrand, selectedCategories: $selectedCategories, selectedSuppliers: $selectedSuppliers, active: $active)
                            .onChange(of: name) { oldValue,newValue in
                                if isUpdate {
                                    self.loading = true
                                    Task {
                                        await FirebaseStorage.deleteFileFromFirebase(filePath: "\(product.slug)")
                                        self.loading = false
                                    }
                                }
                            }
                        
                    } header: {
                        Text("Product Definition")
                    }
                    
                    Section {
                        ConfigurationProduct(isUpdate: self.isUpdate, selectedConfig: $selectedConfig, listConfigurations: $listConfigurations, selectedType: $selectedType)
                            .onChange(of: selectedConfig) { _,_ in
                                if !listConfigurations.isEmpty {
                                    selectedImagesByConfiguration = listConfigurations[selectedConfig].uimages
                                    self.selectedType = self.listConfigurations[selectedConfig].type
                                }
                            }
                            .onChange(of: selectedType) { _,newValue in
                                self.listConfigurations[selectedConfig].type = newValue
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
                                Image(systemName: "minus")
                            }
                            Button {
                                addConfiguration()
                            } label: {
                                Image(systemName: "plus")
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
                                self.loading = true
                                if listConfigurations[selectedConfig].uimages!.count > 0 {
                                    listConfigurations[selectedConfig].uimages?.removeLast()
                                    listConfigurations[selectedConfig].images.removeLast()
                                    selectedImagesByConfiguration = listConfigurations[selectedConfig].uimages
                                    let indexToDelete = listConfigurations[selectedConfig].images.count
                                    if isUpdate {
                                        Task {
                                            await FirebaseStorage.deleteFileFromFirebase(filePath: "\(product.slug)/\(selectedConfig)/\(product.slug)-\(indexToDelete).jpg")
                                            self.loading = false
                                        }
                                        
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                            }
                            .disabled(disableAddImage())
                            Button(action: {
                                showImagePicker = true
                            }, label: {
                                Image(systemName: "plus")
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
        
        .navigationTitle(isUpdate ? "Update Product" :"Add Product")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isUpdate {
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
        .onAppear(perform: fetchData)
    }
    
    @State private var hasFetchedData: Bool = false
    
    func fetchData() {
        guard !hasFetchedData else { return }
        
        if isUpdate {
            selectedBrand.insert( self.product.brand)
            self.product.suppliers.forEach({ selectedSuppliers.insert($0) })
            self.product.categories.forEach({ selectedCategories.insert($0) })
            
            Task {
                loading = true
                do {
                    self.listConfigurations = try await addAndUpdateProductViewModel.getConfigs(productId: self.product.id)
                    
                    self.hasFetchedData = true
                    self.name = self.product.name
                    if self.listConfigurations.count > 0 {
                        self.selectedConfig = 0
                        self.selectedType = self.listConfigurations[selectedConfig].type
                    }
                } catch {
                    handleError(error)
                    //restartViewData()
                }
                loading = false
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
        
        if selectedSuppliers.count < 1 {
            return false
        }
        
        if selectedCategories.count < 1 {
            return false
        }
        
        if selectedBrand.isEmpty {
            return false
        }
        return true
    }
    
    private func updateProduct() {
        Task {
            do {
                self.loading = true
                if isValidAddProduct() {
                    if let brand = selectedBrand.first {
                        self.product.name = name
                        
                        if let b = GlobalDataManagerViewModel.shared.brands.first(where: {$0.id == brand }) {
                            self.product.brand = b.id
                        }
                        self.product.categories = selectedCategories.compactMap({ $0 })
                        self.product.suppliers = selectedSuppliers.compactMap({$0})
                        self.product.isActive = active //falta componente para esto
                        self.product.slug = createSlug(from: name)
                        let _ = try await addAndUpdateProductViewModel.updateProduct(product: product)
                        try await addAndUpdateProductViewModel.updateConfigurations(product: self.product, listConfiguration: listConfigurations)
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
            //print(error.localizedDescription)
        }
        self.loading = false
    }
    
    private func addProduct() {
        Task {
            do {
                self.loading = true
                if isValidAddProduct() {
                    if let product = try await addProductDefinition() {
                        try await addConfigurations(product: product)
                    }
                    restartViewData()
                }
                
            } catch {
                handleError(error)
            }
        }
    }
    
    private func addProductDefinition() async throws -> Product? {
        if let brand = selectedBrand.first  {
            return try await addAndUpdateProductViewModel.addProduct(name: name, brand: brand, categories: selectedCategories, suppliers: selectedSuppliers, active: active)
        }
        return nil
    }
    
    private func addConfigurations(product: Product) async throws {
        try await addAndUpdateProductViewModel.addConfigurations(product: product, listConfiguration: listConfigurations)
    }
    
    private func searchProductByName(name: String) {
        
    }
    
    private func restartViewData() {
        self.product = Product(id: "", name: "", slug: "", isActive: true, categories: [], brand: "", suppliers: [])
        
        self.name = ""
        self.active = true
        self.selectedBrand.removeAll()
        self.selectedSuppliers.removeAll()
        self.selectedCategories.removeAll()
        
        self.selectedConfig = 0
        self.listConfigurations.removeAll()
        
        self.selectedImagesByConfiguration?.removeAll()
        
        self.loading = false
    }
    
    private func addConfiguration() {
        let productConfig = ProductConfig(id: "", price: 0, discountPrice: 0, productionPrice: 0, type: "", selectedColor: .white, colorHex: "#ffffff", size: "", weight: "", images: [], productDescription: "", stock: [] ,isActive: true)
        
        self.listConfigurations.append(productConfig)
        
        if listConfigurations.count == 1 {
            self.selectedConfig = 0
        }
    }
}
