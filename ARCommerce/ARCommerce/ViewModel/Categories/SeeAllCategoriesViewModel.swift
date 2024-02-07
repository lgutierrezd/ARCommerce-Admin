//
//  SeeAllCategoriesViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation


class SeeAllCategoriesViewModel: ObservableObject {
    @Published var categories: [ARCommerce.CategoryV1] = []
    
    @MainActor func getAllCategories(page: Int, limit: Int) async throws {
        let coreCategory = CoreCategory()
        self.categories = try await coreCategory.getCategories(page: page, limit: limit)        
    }
    
    @MainActor func getCategory(id: String) async throws -> ARCommerce.Category {
        let coreCategory = CoreCategory()
        return try await coreCategory.getCategory(id: id)
    }
    
    @MainActor func deleteCategory(category: CategoryV1) async throws -> Bool {
        let coreCategory = CoreCategory()
        return try await coreCategory.deleteCategory(category: category)
    }
    
    @MainActor func updateCategory(category: CategoryV1) async throws -> CategoryV1 {
        let coreCategory = CoreCategory()
        return try await coreCategory.updateCategory(category: category)
    }
}
