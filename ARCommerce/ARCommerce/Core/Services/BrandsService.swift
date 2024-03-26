//
//  BrandsService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Combine

protocol BrandServiceType {
    func getBrands(page: String, limit: String) -> AnyPublisher<BrandsResponse, Error>
    func addBrand(brand: Brand) -> AnyPublisher<BrandResponse, Error>
    func updateBrand(brand: Brand) -> AnyPublisher<BrandResponse, Error>
    func deleteBrand(id: String) -> AnyPublisher<Bool, Error>
}

struct BrandService: BrandServiceType {
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getBrands(page: String, limit: String) -> AnyPublisher<BrandsResponse, Error> {
        requester.get(target: BrandsTarget.getBrands(page: page, limit: limit))
    }
    
    func addBrand(brand: Brand) -> AnyPublisher<BrandResponse, Error> {
        requester.get(target: BrandsTarget.addBrand(brand: brand))
    }
    
    func updateBrand(brand: Brand) -> AnyPublisher<BrandResponse, Error> {
        requester.patch(target: BrandsTarget.updateBrand(brand: brand))
    }
    
    func deleteBrand(id: String) -> AnyPublisher<Bool, Error> {
        requester.delete(target: BrandsTarget.deleteBrand(id: id))
    }
}
