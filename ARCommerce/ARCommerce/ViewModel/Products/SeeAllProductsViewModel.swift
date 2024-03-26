//
//  SeeAllProductsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 13/1/24.
//

import Foundation

class SeeAllProductsViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
//    @MainActor func getAllProducts(page: Int) async throws {
//        do {
//            let coreProducts = CoreProducts()
//            self.products = try await coreProducts.getAllProducts(page: page)
//        } catch {
//            throw error
//        }
//    }
//    
//    func deleteProducts(products: [ProductV1]) async throws ->  [(ProductV1, Bool)] {
//        do {
//            let coreProducts = CoreProducts()
//            let products = try await coreProducts.deleteProducts(products: products)
//            return products
//        } catch {
//            throw error
//        }
//    }
//    
//    func activateProduct(product: ProductV1) async throws ->  Bool {
//        do {
//            let coreProducts = CoreProducts()
//            let products = try await coreProducts.activateProduct(product: product)
//            return products
//        } catch {
//            throw error
//        }
//    }
}
