//
//  AddProductViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftUI

final class AddAndUpdateProductViewModel: ObservableObject {
    
//    @MainActor func getInitialData() throws -> ([Brand]?, [ARCommerce.Category]?, [Supplier]?)? {
//        let coreProducts = CoreProducts()
//        return try coreProducts.getInitialData()
//    }
//    
//    func addProduct(name: String, brand: String, categories: Set<String>, suppliers: Set<String>, active: Bool) async throws -> Product {
//        let coreProducts = CoreProducts()
//        let product = Product(id: "", name: name, slug: "", isActive: active, categories: Array(categories), brand: brand, suppliers: Array(suppliers))
//        return try await coreProducts.addProduct(product: product)
//    }
//    
//    func addConfigurations(product: Product, listConfiguration: [ProductConfig]) async throws {
//        let coreProducts = CoreProducts()
//        let _ = try await coreProducts.addConfigurations(product: product, listConfigurations: listConfiguration)
//    }
//    
//    func updateProduct(product: Product) async throws -> Product {
//        let coreProducts = CoreProducts()
//        return try await coreProducts.updateProduct(product: product)
//    }
//    
//    func updateConfigurations(product: Product, listConfiguration: [ProductConfig]) async throws {
//        let coreProducts = CoreProducts()
//        let _ = try await coreProducts.updateConfigurationsWithFirebase(product: product, listConfigurations: listConfiguration)
//    }
//    
//    func modifyProduct(product: Product, listConfiguration: [ProductConfig]) async throws {
//        let coreProducts = CoreProducts()
//        let _ = try await coreProducts.addConfigurations(product: product, listConfigurations: listConfiguration)
//    }
//    
//    @MainActor func getConfigs(productId: String) async throws -> [ProductConfig] {
//        let coreProducts = CoreProducts()
//        let configs = try await coreProducts.getProductcConfiguration(productId: productId)
//        var productConfig = [ProductConfig]()
//
//        for config in configs {
//            var loadedImages = [UIImage]()
//
//            for stringUrl in config.images {
//                if let img = await loadImageFromURL(url: URL(string: stringUrl)!) {
//                    loadedImages.append(img)
//                }
//            }
//            
//            productConfig.append(
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
//                    uimages: loadedImages,
//                    productDescription: config.productDescription,
//                    stock: config.stock.map({ Stock(location: Location(_id: $0.location, locationName: "", lat: "", lon: ""), quantity: $0.quantity, size: $0.size) }), 
//                    isActive: config.isActive
//                )
//            )
//        }
//
//        return productConfig
//    }
//    
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
//
//    
//    deinit {
//        print("AddProductViewModel deleted")
//    }
}
