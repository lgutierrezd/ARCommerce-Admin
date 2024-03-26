//
//  AddCategoryView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation

class AddCategoryViewModel {
    let categoryService: CategoryServiceType
    init(categoryService: CategoryServiceType = CategoryService()){
        self.categoryService = categoryService
    }
}
