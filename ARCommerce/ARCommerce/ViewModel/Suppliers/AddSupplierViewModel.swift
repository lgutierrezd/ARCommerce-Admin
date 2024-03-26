//
//  AddSupplierViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation

class AddSupplierViewModel {
    
    let supplierService: SupplierServiceType
    init(supplierService: SupplierServiceType = SupplierService()) {
        self.supplierService = supplierService
    }
}
