//
//  ProductService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/25/24.
//

import Foundation
import Combine

protocol ProductServiceType {
    func getAllProducts(page: String, limit: String) -> AnyPublisher<ProductsResponse, Error>
    func getProduct(id: String) -> AnyPublisher<ProductResponse, Error>
    func createProduct(product: Product) -> AnyPublisher<ProductResponse, Error>
    func updateProduct(product: Product) -> AnyPublisher<ProductResponse, Error>
    func deleteProduct_isActive(id: String, isActive: Bool) -> AnyPublisher<Bool, Error>
}

struct ProductService: ProductServiceType {
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getAllProducts(page: String, limit: String) -> AnyPublisher<ProductsResponse, Error> {
        requester.get(target: ProductsTarget.getAllProducts(page: page, limit: limit))
    }
    
    func getProduct(id: String) -> AnyPublisher<ProductResponse, Error> {
        requester.get(target: ProductsTarget.getProduct(id: id))
    }
    
    func createProduct(product: Product) -> AnyPublisher<ProductResponse, Error> {
        requester.post(target: ProductsTarget.createProduct(product: product))
    }
    
    func updateProduct(product: Product) -> AnyPublisher<ProductResponse, Error> {
        requester.patch(target: ProductsTarget.updateProduct(product: product))
    }
    
    func deleteProduct_isActive(id: String, isActive: Bool) -> AnyPublisher<Bool, Error> {
        requester.delete(target: ProductsTarget.deleteProduct_isActive(id: id, isActive: isActive))
    }
    
    
}
