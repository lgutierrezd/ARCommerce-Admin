//
//  BrandsTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum BrandsTarget: NetworkingTargetType {
    case getBrands(page: String, limit: String)
    case getBrand(id: String)
    case addBrand(brand: Brand)
    case updateBrand(brand: Brand)
    case deleteBrand(id: String)
    
    var requestPath: String {
        switch self {
        case .getBrands(page: _, limit: _):
            return "api/v1/brand"
        case .addBrand(brand: _):
            return "api/v1/brand"
        case .updateBrand(brand: let brand):
            return "api/v1/brand/\(brand.id)"
        case .deleteBrand(id: let id):
            return "api/v1/brand/\(id)"
        case .getBrand(id: let id):
            return "api/v1/brand/\(id)"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .getBrands:
                .get
        case .addBrand(brand: _):
                .post
        case .updateBrand(brand: _):
                .patch
        case .deleteBrand(id: _):
                .delete
        case .getBrand(id: let id):
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBrands(page: let page, limit: let limit):
            let parameters = ["page": page, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .addBrand(brand: let brand):
            let requestBody: [String: Any] = [
                "name": brand.name,
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateBrand(brand: let brand):
            let requestBody: [String: Any] = [
                "name": brand.name,
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .deleteBrand(id: _):
            return .requestPlain
        case .getBrand(id: let id):
            return .requestPlain
        }
    }
    
}
