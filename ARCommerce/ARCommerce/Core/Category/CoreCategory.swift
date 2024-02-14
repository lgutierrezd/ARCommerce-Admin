//
//  CoreCategory.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation
class CoreCategory {
    let database: DatabaseFacade
    
    init() {
        self.database = DatabaseFacade()
    }
    
    func getCategories(page: Int, limit: Int) async throws -> [ARCommerce.CategoryV1] {
        do {
            let apiCategories = APICategories()
            return try await apiCategories.getCategories(page: page, limit: limit)
        } catch {
            throw error
        }
    }
    
    func getCategory(id: String) async throws -> ARCommerce.Category {
        do {
            let apiCategories = APICategories()
            return try await apiCategories.getCategory(id: id)
        } catch {
            throw error
        }
    }
    
    func addCategory(category: ARCommerce.CategoryV1) async throws -> ARCommerce.CategoryV1 {
        do {
            let apiCategories = APICategories()
            let category = try await apiCategories.addCategory(category: category)
            if let childs = category.childs {
                let storeNewCategory: ARCommerce.Category = ARCommerce.Category(
                    _id: category._id,
                    name: category.name,
                    childs: childs,
                    setup: category.setup)
                
                try await database.insertRecord(storeNewCategory)
            }
 
            
            return category
        } catch {
            throw error
        }
    }
    
    func updateCategory(category: ARCommerce.CategoryV1) async throws -> ARCommerce.CategoryV1 {
        do {
            let apiCategory = APICategories()
            return try await apiCategory.updateCategory(category: category)
        } catch {
            throw error
        }
    }
    
    func deleteCategory(category: ARCommerce.CategoryV1) async throws -> Bool {
        do {
            let apiCategories = APICategories()
            return try await apiCategories.deleteCategory(id: category._id)
            
        } catch {
            throw error
        }
    }
}
