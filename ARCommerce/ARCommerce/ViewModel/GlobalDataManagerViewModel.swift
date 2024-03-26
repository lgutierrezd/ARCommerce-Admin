//
//  GlobalDataManagerViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 18/1/24.
//

import Combine

class GlobalDataManagerViewModel: ObservableObject {
    static let shared = GlobalDataManagerViewModel()
    
    @Published var brands: [Brand] = []
    @Published var categories: [ARCommerce.Category] = []
    @Published var suppliers: [Supplier] = []
    @Published var locations: [Location] = []
    
    //Change the position of the menu
    @Published var selectedItem: MenuItem?
    //Select a product when we want to update
    @Published var selectedProduct: Product?
    
    
}
