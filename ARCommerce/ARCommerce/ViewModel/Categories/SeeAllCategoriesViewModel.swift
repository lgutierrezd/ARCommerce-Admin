//
//  SeeAllCategoriesViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation


class SeeAllCategoriesViewModel: ObservableObject {
    @Published var categories: [ARCommerce.Category] = []
    let categoryService: CategoryServiceType
    init(categoryService: CategoryServiceType = CategoryService()){
        self.categoryService = categoryService
    }
}
