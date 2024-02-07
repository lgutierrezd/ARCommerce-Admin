//
//  Core+ProductsSeeAll.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 13/1/24.
//

import Foundation

extension CoreProducts {
    func getAllProducts(page: Int) async throws -> [ProductV1] {
        do {
            let apiSeeAllProduct = APIProductsSeeAll()
            return try await apiSeeAllProduct.getAllProducts(page: page)
        } catch {
            throw error
        }
    }
    
    func deleteProducts(products: [ProductV1]) async throws -> [(ProductV1, Bool)] {
        let apiSeeAllProducts = APIProductsSeeAll()
        
        var deletionResults: [(ProductV1, Bool)] = []
        for product in products {
            do {
                let finished = try await apiSeeAllProducts.deleteProduct(id: product._id )
                deletionResults.append((product, finished))
            } catch {
                deletionResults.append((product, false))
            }
            
        }
        
        return deletionResults
    }
    
    func activateProduct(product: ProductV1) async throws -> Bool {
        let apiSeeAllProducts = APIProductsSeeAll()
        return try await apiSeeAllProducts.activateProduct(id: product._id)
    }
}
