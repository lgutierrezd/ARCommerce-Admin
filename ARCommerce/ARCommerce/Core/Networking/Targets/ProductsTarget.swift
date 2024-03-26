//
//  ProductTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum ProductsTarget: NetworkingTargetType {
    case getAllProducts(page: String, limit: String)
    case getProduct(id: String)
    case createProduct(product: Product)
    case updateProduct(product: Product)
    case deleteProduct_isActive(id: String, isActive: Bool)
    
    var requestPath: String {
        switch self {
        case .getAllProducts(page: let page, limit: let limit):
            return "api/v1/products"
        case .getProduct(id: let id):
            return "api/v1/products/\(id)"
        case .createProduct(product: let product):
            return "api/v1/products"
        case .updateProduct(product: let product):
            return "api/v1/products/\(product.id)"
        case .deleteProduct_isActive(id: let id, isActive: let isActive):
            return "api/v1/products/\(id)"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .getAllProducts(page: let page, limit: let limit):
                .get
        case .getProduct(id: let id):
                .get
        case .createProduct(product: let product):
                .post
        case .updateProduct(product: let product):
                .patch
        case .deleteProduct_isActive(id: let id, isActive: let isActive):
                .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllProducts(page: let page, limit: let limit):
            let parameters = ["page": page, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getProduct(id: let id):
            return .requestPlain
        case .createProduct(product: let product):
            let requestBody = createProductRequestBody(product: product)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateProduct(product: let product):
            let requestBody = createProductRequestBody(product: product)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .deleteProduct_isActive(id: let id, isActive: let isActive):
            let requestBody: [String: Any] = [
                "isActive": isActive,
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        }
    }
    
    func createProductRequestBody(product: Product) -> Dictionary<String, Any> {
        return [
            "name": product.name,
            "slug": product.slug,
            "categories": product.categories.compactMap({ $0 }),
            "brand": product.brand?.id ?? "",
            "suppliers": product.suppliers.compactMap { $0 },
            "isActive": product.isActive,
            "config": []
        ]
    }
    
}
