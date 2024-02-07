//
//  AddCategoryView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation

class AddCategoryViewModel {
    
    func addCategory(name: String, selectedParent: ARCommerce.CategoryV1?, setup: [Setup]?) async throws -> ARCommerce.CategoryV1 {
        let coreCategory = CoreCategory()
        if let parent = selectedParent, let sp = setup {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, parent: parent, setup: sp))
        }
        if let parent = selectedParent {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, parent: parent))
        }
        if let sp = setup {
            return try await coreCategory.addCategory(category: CategoryV1(_id: "", name: name, setup: sp))
        }
        throw CustomError.credentialError
    }
    
    
}
