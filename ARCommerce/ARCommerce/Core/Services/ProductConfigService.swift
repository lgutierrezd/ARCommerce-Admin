//
//  ProductConfigService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/25/24.
//

import Foundation
import Combine

protocol ProductConfigServiceType {
    func getProductConfig(idProduct: String) -> AnyPublisher<ProductDetailResponse, Error>
    func getDetailProductView(idProductConfig: String) -> AnyPublisher<DetailProductResponse, Error>
    func addProductConfig(productDetail: ProductDetail) -> AnyPublisher<ProductDetailResponse, Error>
    func updateProductConfig(productDetail: ProductDetail) -> AnyPublisher<Bool, Error>
}

struct ProductConfigService: ProductConfigServiceType {
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getProductConfig(idProduct: String) -> AnyPublisher<ProductDetailResponse, Error> {
        requester.get(target: ProductsConfigTarget.getProductConfig(idProduct: idProduct))
    }
    
    func getDetailProductView(idProductConfig: String) -> AnyPublisher<DetailProductResponse, Error> {
        requester.get(target: ProductsConfigTarget.getDetailProductView(idProductConfig: idProductConfig))
    }
    
    func addProductConfig(productDetail: ProductDetail) -> AnyPublisher<ProductDetailResponse, Error> {
        requester.post(target: ProductsConfigTarget.addProductConfig(productDetail: productDetail))
    }
    
    func updateProductConfig(productDetail: ProductDetail) -> AnyPublisher<Bool, Error> {
        requester.patch(target: ProductsConfigTarget.updateProductConfig(productDetail: productDetail))
    }
    
    
}
