//
//  Suppliers.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum SupplierTarget: NetworkingTargetType {
    case getSuppliers(page: String, limit: String)
    case getSupplier(id: String)
    case addSupplier(supplier: Supplier)
    case updateSupplier(supplier: Supplier)
    case deleteSupplier(id: String)
    
    var requestPath: String {
        switch self {
        case .getSuppliers(page: _, limit: _):
            return "api/v1/supplier"
        case .getSupplier(id: let id):
            return "api/v1/supplier/\(id)"
        case .addSupplier(supplier: _):
            return "api/v1/supplier"
        case .updateSupplier(supplier: let supplier):
            return "api/v1/supplier/\(supplier.id)"
        case .deleteSupplier(id: let id):
            return "api/v1/supplier/\(id)"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .getSuppliers(page: _, limit: _):
            return .get
        case .getSupplier(id: _):
            return .get
        case .addSupplier(supplier: _):
            return .post
        case .updateSupplier(supplier: _):
            return .patch
        case .deleteSupplier(id: _):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSuppliers(page: let page, limit: let limit):
            let parameters = ["page": page, "limit": limit]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getSupplier(id: _):
            return .requestPlain
        case .addSupplier(supplier: let supplier):
            let requestBody = [
                "name": supplier.name,
                "email": supplier.email,
                "phone": supplier.phone
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateSupplier(supplier: let supplier):
            let requestBody = [
                "name": supplier.name,
                "email": supplier.email,
                "phone": supplier.phone
            ]
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .deleteSupplier(id: _):
            return .requestPlain
        }
    }
    
}
