//
//  CategoryService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Combine

protocol CategoryServiceType {
    func getCategories(page: String, limit: String) -> AnyPublisher<CategoriesResponse, Error>
    func addCategory(category: Category) -> AnyPublisher<CategoryResponse, Error>
    func updateCategory(category: Category) -> AnyPublisher<CategoryResponse, Error>
    func deleteCategory(id: String) -> AnyPublisher<Bool, Error>
}

struct CategoryService: CategoryServiceType {

    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func getCategories(page: String, limit: String) -> AnyPublisher<CategoriesResponse, Error> {
        requester.get(target: CategoriesTarget.getCategories(page: page, limit: limit))
    }
    
    func addCategory(category: Category) -> AnyPublisher<CategoryResponse, Error> {
        requester.get(target: CategoriesTarget.addCategory(category: category))
    }
    
    func updateCategory(category: Category) -> AnyPublisher<CategoryResponse, Error> {
        requester.patch(target: CategoriesTarget.updateCategory(category: category))
    }
    
    func deleteCategory(id: String) -> AnyPublisher<Bool, Error> {
        requester.delete(target: CategoriesTarget.deleteCategory(id: id))
    }
}
