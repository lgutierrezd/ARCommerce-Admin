//
//  SeeAllProductsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class SeeAllSuppliersViewModel: ObservableObject {
    
    @Published var suppliers: [Supplier] = []
    
    @MainActor func getSuppliers() async throws  {
        let coreSupplier = CoreSupplier()
        self.suppliers = try await coreSupplier.getSuppliers()
    }
    
    @MainActor func deleteSuppliers(id: String) async throws -> Bool {
        let coreSupplier = CoreSupplier()
        return try await coreSupplier.deleteSupplier(id: id)
    }
    
    @MainActor func updateSupplier(id: String, supplier: Supplier) async throws -> Supplier {
        let coreSupplier = CoreSupplier()
        return try await coreSupplier.updateSupplier(id: id, supplier: supplier)
    }
}
