//
//  ProductsConfigTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/25/24.
//

import Foundation
import Moya

enum ProductsConfigTarget: NetworkingTargetType {
    case getProductConfig(idProduct: String)
    case getDetailProductView(idProductConfig: String)
    case addProductConfig(productDetail: ProductDetail)
    case updateProductConfig(productDetail: ProductDetail)
    
    var requestPath: String {
        switch self {
        case .getProductConfig(idProduct: let idProduct):
            return "api/v1/products/config/\(idProduct)"
        case .getDetailProductView(idProductConfig: let idProductConfig):
            return "api/v1/products/detailProductView/\(idProductConfig)"
        case .addProductConfig(productDetail: let productDetail):
            return "api/v1/products/config/\(productDetail._id)"
        case .updateProductConfig(productDetail: let productDetail):
            return "api/v1/products/config/\(productDetail._id)"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .getProductConfig(idProduct: let idProduct):
            return .get
        case .getDetailProductView(idProductConfig: let idProductConfig):
            return .get
        case .addProductConfig(productDetail: let productDetail):
            return .post
        case .updateProductConfig(productDetail: let productDetail):
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProductConfig(idProduct: let idProduct):
            return .requestPlain
        case .getDetailProductView(idProductConfig: let idProductConfig):
            return .requestPlain
        case .addProductConfig(productDetail: let productDetail):
            let requestBody = createProductConfigRequestBody(productDetail: productDetail)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        case .updateProductConfig(productDetail: let productDetail):
            let requestBody = createProductConfigRequestBody(productDetail: productDetail)
            return .requestParameters(parameters: requestBody, encoding: JSONEncoding.default)
        }
    }
    
    func createProductConfigRequestBody(productDetail: ProductDetail) -> Dictionary<String, Any> {
        var mainBody : [String: Array] = [
            "configs": []
        ]
        
        for configuration in productDetail.configs {
            let images: [String] = configuration.images.compactMap { $0 }
            
            var stocks: [[String: Any]] = []
            if let stock = configuration.stock {
                stock.forEach({
                    let stock: [String: Any] = [
                        "location": $0.location,
                        "quantity": $0.quantity,
                        "size": $0.size,
                    ]
                    stocks.append(stock)
                })
            }
            
            
            let requestBody: [String: Any] = [
                "price": configuration.price,
                "productionPrice": configuration.productionPrice,
                "discountPrice": configuration.discountPrice,
                "type": configuration.type,
                "size": configuration.size,
                "weight": configuration.weight,
                "colorHex": configuration.colorHex,
                "productDescription": configuration.productDescription,
                "isActive": configuration.isActive,
                "images": images,
                "imagesUrl": configuration.imagesUrl,
                "stock": stocks
            ]
            mainBody["configs"]?.append(requestBody)
        }
        
        return mainBody
    }
    
}
