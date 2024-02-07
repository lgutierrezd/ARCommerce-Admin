//
//  SeeAllBrandsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class SeeAllBrandsViewModel: ObservableObject {
    
    @Published var brands: [Brand] = []
    
    @MainActor func getAllBrands() async throws {
        let coreBrand = CoreBrand()
        self.brands = try await coreBrand.getBrands()
    }
    
    func updateBrand(id: String, name: String) async throws -> Brand {
        let coreBrand = CoreBrand()
        return try await coreBrand.updateBrand(brand: Brand(id: id, name: name))
    }
    
    func deleteBrand(brand: Brand) async throws -> Bool {
        let coreBrand = CoreBrand()
        return try await coreBrand.deleteBrand(brand: brand)
    }
}
