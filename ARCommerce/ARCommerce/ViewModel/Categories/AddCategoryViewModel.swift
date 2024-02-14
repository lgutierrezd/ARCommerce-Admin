//
//  AddCategoryView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation

class AddCategoryViewModel {
    
    func addCategory(name: String, selectedChilds: [String]?, setup: [Setup]?) async throws -> ARCommerce.CategoryV1 {
        let coreCategory = CoreCategory()
        if let childs = selectedChilds, let sp = setup {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, childs: childs, setup: sp))
        }
        if let childs = selectedChilds {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, childs: childs))
        }
        if let sp = setup {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, setup: sp))
        }
        throw CustomError.credentialError
    }
    
    
}
