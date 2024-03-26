//
//  AddBrandViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class AddBrandViewModel {
    let brandService: BrandServiceType
    
    init(brandService: BrandServiceType = BrandService()) {
        self.brandService = brandService
    }
}
