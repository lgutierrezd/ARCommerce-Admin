//
//  AddProductViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftUI

final class AddAndUpdateProductViewModel: ObservableObject {
    
    @MainActor func getInitialData() throws -> ([Brand]?, [ARCommerce.Category]?, [Supplier]?)? {
        let coreProducts = CoreProducts()
        return try coreProducts.getInitialData()
    }
    
    func addProduct(name: String, brand: Brand, categories: Set<String>, suppliers: Set<String>, active: Bool) async throws -> Product {
        let coreProducts = CoreProducts()
        return try await coreProducts.addProduct(name: name, brand: brand, categories: categories, suppliers: suppliers, active: active)
    }
    
    func addConfigurations(product: ProductV1, listConfiguration: [ProductConfig]) async throws {
        let coreProducts = CoreProducts()
        let _ = try await coreProducts.addConfigurations(product: product, listConfigurations: listConfiguration)
    }
    
    func updateProduct(product: ProductV1) async throws -> Product {
        let coreProducts = CoreProducts()
        return try await coreProducts.updateProduct(product: product)
    }
    
    func updateConfigurations(product: ProductV1, listConfiguration: [ProductConfig]) async throws {
        let coreProducts = CoreProducts()
        let _ = try await coreProducts.updateConfigurations(product: product, listConfigurations: listConfiguration)
    }
    
    func modifyProduct(product: ProductV1, listConfiguration: [ProductConfig]) async throws {
        let coreProducts = CoreProducts()
        let _ = try await coreProducts.addConfigurations(product: product, listConfigurations: listConfiguration)
    }
    
    @MainActor func getConfigs(productId: String) async throws -> [ProductConfig] {
        let coreProducts = CoreProducts()
        let configs = try await coreProducts.getProductcConfiguration(productId: productId)
        var productConfig = [ProductConfig]()

        for config in configs {
            var loadedImages = [UIImage]()

            for stringUrl in config.images {
                if let img = await loadImageFromURL(url: URL(string: stringUrl)!) {
                    loadedImages.append(img)
                }
            }
            
            productConfig.append(
                ProductConfig(
                    id: config._id,
                    price: config.price,
                    discountPrice: config.discountPrice,
                    productionPrice: config.productionPrice,
                    type: config.type,
                    selectedColor: Color(hex: config.colorHex),
                    colorHex: config.colorHex,
                    size: config.size,
                    weight: config.weight,
                    images: config.images,
                    uimages: loadedImages,
                    productDescription: config.productDescription,
                    isActive: config.isActive
                )
            )
        }

        return productConfig
    }
    

    func loadImageFromURL(url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            return nil
        }
    }

    
    deinit {
        print("AddProductViewModel deleted")
    }
}
