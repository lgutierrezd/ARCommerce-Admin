//
//  AddBrandViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class AddBrandViewModel {
    
    func addBrand(name: String) async throws -> Brand {
        let coreBrand = CoreBrand()
        return try await coreBrand.addBrand(brand: Brand(id: "", name: name))
    }
}
