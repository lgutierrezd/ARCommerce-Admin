//
//  GlobalDataManagerViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 18/1/24.
//

import Foundation
class GlobalDataManagerViewModel: ObservableObject {
    static let shared = GlobalDataManagerViewModel()
    
    @Published var brands: [Brand] = []
    @Published var categories: [ARCommerce.Category] = []
    @Published var suppliers: [Supplier] = []
    
    //Change the position of the menu
    @Published var selectedItem: MenuItem?
    
    @Published var selectedProduct: ProductV1?

    @MainActor func getInitialData() throws {
        let coreProducts = CoreProducts()
        let data = try coreProducts.getInitialData()
        if let brands = data?.0, let categories = data?.1, let suppliers = data?.2 {
            self.brands = brands
            self.categories = categories
            self.suppliers = suppliers
        }
    }
}
