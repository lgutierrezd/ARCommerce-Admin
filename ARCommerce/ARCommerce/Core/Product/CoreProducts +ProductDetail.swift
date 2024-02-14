//
//  Core+ProductDetail.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 10/1/24.
//

import Foundation

extension CoreProducts {
    func addConfigurations(product: ProductV1, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let newConfigs = try await saveConfigurationImagesFirebase(product: product, listConfigurations: listConfigurations)
        
        let apiProductConfig = APIProductDetail()
        let productDetail = try await apiProductConfig.addConfigurations(product: product, listConfigurations: newConfigs)
        return productDetail
    }

    func updateConfigurations(product: ProductV1, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let newConfigs = try await saveConfigurationImagesFirebase(product: product, listConfigurations: listConfigurations)
        
        let apiProductConfig = APIProductDetail()
        let productDetail = try await apiProductConfig.updateConfigurations(product: product, listConfigurations: newConfigs)
        return productDetail
    }
    
    func saveConfigurationImagesFirebase(product: ProductV1, listConfigurations: [ProductConfig]) async throws -> [ProductConfig] {
        do {
            for (indexConfig, config) in listConfigurations.enumerated() {
                if let uimages = config.uimages {
                    for (index, image) in uimages.enumerated() {
                        let path = "\(product.slug)/\(indexConfig)"
                        let name = "\(product.slug)-\(index).jpg"
                        if let urlDownload = try await FirebaseStorage.persistImageToStorage(path: path, name: name, image: image) {
                            listConfigurations[indexConfig].images.append(urlDownload)
                        }
                    }
                }
            }
            return listConfigurations
        } catch {
            throw error
        }
    }
    
    func getProductcConfiguration(productId: String) async throws -> [Config] {
        let apiProductConfig = APIProductDetail()
        return try await apiProductConfig.getProductcConfiguration(productId: productId)
    }
}
