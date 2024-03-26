////
////  ManageProductViewModel.swift
////  ARCommerce
////
////  Created by Luis Gutierrez on 3/5/24.
////
//
//import SwiftUI
//import Combine
//
//class ManageProductViewModel: ObservableObject {
//    let isUpdate: Bool
//    @Published var product: ProductV1
//    
//    @Published var selectedBrand: Set<String>
//    @Published var selectedCategories: Set<String>
//    @Published var selectedSuppliers: Set<String>
//    
//    @Published var listConfigurations: [ProductConfig] = []
//    
//    @Published var isLoading = false
//    @Published var isLoadingImages = false
//    @Published var hasFetchedData: Bool = false
//    
//    private var cancellables: [AnyCancellable] = []
//    
//    @Published var showAlert = false
//    @Published var alertText: String = ""
//    
//    init(isUpdate: Bool, product: ProductV1, selectedBrand: Set<String>, selectedCategories: Set<String>, selectedSuppliers: Set<String>) {
//        self.isUpdate = isUpdate
//        self.product = product
//        self.selectedBrand = selectedBrand
//        self.selectedCategories = selectedCategories
//        self.selectedSuppliers = selectedSuppliers
//    }
//    
//    @MainActor func addProduct() async throws {
//        let coreProducts = CoreProducts()
//        isLoading = true
//        try await coreProducts.addProduct(product: Product(id: "", name: self.product.name, slug: "", isActive: self.product.isActive, categories: [], brand: "", suppliers: []), listConfigurations: self.listConfigurations, selectedBrand: self.selectedBrand, selectedCategories: self.selectedCategories, selectedSuppliers: self.selectedSuppliers)
//        isLoading = false
//    }
//    
//    @MainActor func updateProduct() async throws {
//        let coreProducts = CoreProducts()
//        isLoading = true
//        try await coreProducts.updateProduct(product: Product(id: self.product._id, name: self.product.name, slug: self.product.slug, isActive: self.product.isActive, categories: [], brand: "", suppliers: []), listConfigurations: self.listConfigurations, selectedBrand: self.selectedBrand, selectedCategories: self.selectedCategories, selectedSuppliers: self.selectedSuppliers)
//        isLoading = false
//    }
//    
//    @MainActor func updateProductConfiguration() async throws {
//        let coreProducts = CoreProducts()
//        isLoading = true
//        try await coreProducts.updateConfiguration(product: Product(id: self.product._id, name: self.product.name, slug:  self.product.slug, isActive: self.product.isActive, categories: [], brand: "", suppliers: []), listConfigurations: self.listConfigurations)
//        isLoading = false
//    }
//    
//    @MainActor func getConfigs(productId: String) async throws {
//        self.isLoading = true
//        let coreProducts = CoreProducts()
//        
//        let configs = try await coreProducts.getProductcConfiguration(productId: productId)
//        
//        let locations = GlobalDataManagerViewModel.shared.locations
//        
//        for config in configs {
//            listConfigurations.append(
//                ProductConfig(
//                    id: config._id,
//                    price: config.price,
//                    discountPrice: config.discountPrice,
//                    productionPrice: config.productionPrice,
//                    type: config.type,
//                    selectedColor: Color(hex: config.colorHex),
//                    colorHex: config.colorHex,
//                    size: config.size,
//                    weight: config.weight,
//                    images: config.images,
//                    uimages: [],
//                    productDescription: config.productDescription,
//                    stock: config.stock.map({ stock in
//                        if let loc = locations.first(where: { location in
//                            location._id == stock.location
//                        }) {
//                            return Stock(location: loc, quantity: stock.quantity, size: stock.size)
//                        } else {
//                            // Proporciona un valor predeterminado o maneja la falta de ubicación
//                            return Stock(location: Location(_id: "", locationName: "", lat: "", lon: ""), quantity: 0, size: "")
//                        }
//                    }),
//                    isActive: config.isActive
//                )
//            )
//        }
//        listConfigurations.publisher.sink{ [weak self] newValue in
//            self?.isLoading = false
//            self?.hasFetchedData = true
//            Task {
//                self?.isLoadingImages = true
//                for stringUrl in newValue.images {
//                    if let img = await self?.loadImageFromURL(url: URL(string: stringUrl)!) {
//                        if let index = self?.listConfigurations.firstIndex(where: { $0.id == newValue.id }) {
//                            self?.listConfigurations[index].uimages.append(img)
//                        }
//                    }
//                }
//                self?.isLoadingImages = false
//            }
//        }.store(in: &cancellables)
//    }
//    
//    func loadImageFromURL(url: URL) async -> UIImage? {
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            return UIImage(data: data)
//        } catch {
//            print("Error loading image: \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
