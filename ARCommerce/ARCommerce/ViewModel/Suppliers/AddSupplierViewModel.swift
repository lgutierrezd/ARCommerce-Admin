//
//  AddSupplierViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation

class AddSupplierViewModel: ObservableObject {
    
    func addSupplier(name: String, email: String, phone:  String) async throws -> Supplier {
        let coreSupplier = CoreSupplier()
        return try await coreSupplier.addSupplier(supplier: Supplier(id: "", name: name, email: email, phone: phone))
    }
}
