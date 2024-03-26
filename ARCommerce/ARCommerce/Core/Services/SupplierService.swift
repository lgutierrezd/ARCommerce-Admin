//
//  SupplierService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/25/24.
//

import Foundation
import Combine

protocol SupplierServiceType {
    func getSuppliers(page: String, limit: String) -> AnyPublisher<SuppliersResponse, Error>
    func getSupplier(id: String) -> AnyPublisher<SupplierResponse, Error>
    func addSupplier(supplier: Supplier) -> AnyPublisher<SupplierResponse, Error>
    func updateSupplier(supplier: Supplier) -> AnyPublisher<SupplierResponse, Error>
    func deleteSupplier(id: String) -> AnyPublisher<Bool, Error>
}

struct SupplierService: SupplierServiceType {
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getSuppliers(page: String, limit: String) -> AnyPublisher<SuppliersResponse, Error> {
        requester.get(target: SupplierTarget.getSuppliers(page: page, limit: limit))
    }
    
    func getSupplier(id: String) -> AnyPublisher<SupplierResponse, Error> {
        requester.get(target: SupplierTarget.getSupplier(id: id))
    }
    
    func addSupplier(supplier: Supplier) -> AnyPublisher<SupplierResponse, Error> {
        requester.get(target: SupplierTarget.addSupplier(supplier: supplier))
    }
    
    func updateSupplier(supplier: Supplier) -> AnyPublisher<SupplierResponse, Error> {
        requester.get(target: SupplierTarget.updateSupplier(supplier: supplier))
    }
    
    func deleteSupplier(id: String) -> AnyPublisher<Bool, Error> {
        requester.get(target: SupplierTarget.deleteSupplier(id: id))
    }
}
