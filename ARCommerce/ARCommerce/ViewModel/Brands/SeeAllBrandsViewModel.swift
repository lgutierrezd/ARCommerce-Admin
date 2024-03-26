//
//  SeeAllBrandsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class SeeAllBrandsViewModel: ObservableObject {
    @Published var brands: [Brand] = []
    
    let brandService: BrandServiceType
    
    init(brandService: BrandServiceType = BrandService()) {
        self.brandService = brandService
    }
    
}
