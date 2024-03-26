//
//  CategoriesTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum CategoriesTarget: NetworkingTargetType {
    case getCategories(page: String, limit: String)
    case getCategory(id: String)
    case addCategory(category: Category)
    case updateCategory(category: Category)
    case deleteCategory(id: String)
    
    var requestPath: String {
        switch self {
        case .getCategories(page: let page, limit: let limit):
            return "api/v1/categories"
        case .getCategory(id: let id):
            return "api/v1/categories/\(id)"
        case .addCategory(category: let category):
            return "api/v1/categories"
        case .updateCategory(category: let category):
            return "api/v1/categories/\(category.id)"
        case .deleteCategory(id: let id):
            return "api/v1/categories/\(id)"
        }
    }
    var requestMethod: Moya.Method {
        switch self {
        case .getCategories(page: let page, limit: let limit):
            return .get
        case .getCategory(id: let id):
            return .get
        case .addCategory(category: let category):
            return .post
        case .updateCategory(category: let category):
            return .patch
        case .deleteCategory(id: let id):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCategories(page: let page, limit: let limit):
            let parameters = ["page": page, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getCategory(id: _):
            return .requestPlain
        case .addCategory(category: let category):
            let requestBody = createBodyParamsCategory(category: category)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateCategory(category: let category):
            let requestBody = createBodyParamsCategory(category: category)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .deleteCategory(id: _):
            return .requestPlain
        }
    }
}

extension CategoriesTarget {
    func createBodyParamsCategory(category: Category) -> Dictionary<String, Any> {
        var requestBody: [String: Any] = [:]
        if let _isIdEmpty = category.childs?.isEmpty, let isMain = category.isMain {
            if _isIdEmpty {
                requestBody = [
                    "name": category.name,
                    "isMain": isMain,
                    "setup": []
                ]
            } else {
                requestBody = [
                    "name": category.name,
                    "childs": category.childs ?? [],
                    "isMain": isMain,
                    "setup": []
                ]
            }
            
        } else {
            requestBody = [
                "name": category.name,
                "setup": []
            ]
        }
        
        if let setup = category.setup {
            var setupArray: [[String: Any]] = []
             setup.forEach { d in
                 let sp: [String: Any] = ["key": d.key, "value": d.value]
                 setupArray.append(sp)
             }
             requestBody["setup"] = setupArray
        }
        
        return requestBody
    }
}
