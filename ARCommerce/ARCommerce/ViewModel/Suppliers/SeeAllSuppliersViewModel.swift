//
//  SeeAllProductsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

class SeeAllSuppliersViewModel: ObservableObject {
    @Published var suppliers: [Supplier] = []
    
    let supplierService: SupplierServiceType
    init(supplierService: SupplierServiceType = SupplierService()) {
        self.supplierService = supplierService
    }
    
}
