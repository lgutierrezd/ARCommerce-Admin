//
//  Core+ProductDetail.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 10/1/24.
//

import Foundation

extension CoreProducts {
    func addConfigurations(product: Product, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let newConfigs = try await saveConfigurationImagesFirebase(slug: product.slug, listConfigurations: listConfigurations)
        
        let apiProductConfig = APIProductDetail()
        let productDetail = try await apiProductConfig.addConfigurations(productId: product.id, listConfigurations: newConfigs)
        return productDetail
    }

    func updateConfigurations(product: Product, listConfigurations: [ProductConfig]) async throws -> ProductConfigResult {
        let newConfigs = try await saveConfigurationImagesFirebase(slug: product.slug, listConfigurations: listConfigurations)
        
        let apiProductConfig = APIProductDetail()
        let productDetail = try await apiProductConfig.updateConfigurations(productId: product.id, listConfigurations: newConfigs)
        return productDetail
    }
    
    func saveConfigurationImagesFirebase(slug: String, listConfigurations: [ProductConfig]) async throws -> [ProductConfig] {
        do {
            var newList = listConfigurations
            
            for (indexConfig, config) in listConfigurations.enumerated() {
                newList[indexConfig].images.removeAll()
                if let uimages = config.uimages {
                    for (index, image) in uimages.enumerated() {
                        let path = "\(slug)/\(indexConfig)"
                        let name = "\(slug)-\(index).jpg"
                        if let urlDownload = try await FirebaseStorage.persistImageToStorage(path: path, name: name, image: image) {
                            newList[indexConfig].images.append(urlDownload)
                        }
                    }
                }
            }
            return newList
        } catch {
            throw error
        }
    }
    
    func getProductcConfiguration(productId: String) async throws -> [Config] {
        let apiProductConfig = APIProductDetail()
        return try await apiProductConfig.getProductcConfiguration(productId: productId)
    }
}
