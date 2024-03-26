//
//  UserTarget.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Moya

enum UserTarget: NetworkingTargetType {
    case login(email: String, password: String)
    case signUp(name: String, email: String, password: String, passwordConfirm: String)
    case forgotPassword(email: String)
    case logout
    case resetPassword(token: String, password: String, passwordConfirm: String)
    case updateMyPassword(passwordCurrent: String, password: String, passwordConfirm: String)
    case updateMe
    case deleteMe
    
    var requestPath: String {
        switch self {
        case .login(email: _, password: _):
            return "api/v1/users/login"
        case .signUp(name: _, email: _, password: _, passwordConfirm: _):
            return "api/v1/users/signup"
        case .forgotPassword(email: _):
            return "api/v1/users/forgotPassword"
        case .logout:
            return "api/v1/users/logout"
        case .resetPassword(token: let token, password: _, passwordConfirm: _):
            return "api/v1/users/resetPassword\(token)"
        case .updateMyPassword(passwordCurrent: _, password: _, passwordConfirm: _):
            return "api/v1/users/updateMyPassword"
        case .updateMe:
            return "api/v1/users/updateMe"
        case .deleteMe:
            return "api/v1/users/deleteMe"
        }
    }
    
    var requestMethod: Moya.Method {
        switch self {
        case .login(email: let email, password: let password):
            return .post
        case .signUp(name: let name, email: let email, password: let password, passwordConfirm: let passwordConfirm):
            return .post
        case .forgotPassword(email: let email):
            return .post
        case .logout:
            return .get
        case .resetPassword(token: _, password: let password, passwordConfirm: let passwordConfirm):
            return .patch
        case .updateMyPassword(passwordCurrent: let passwordCurrent, password: let password, passwordConfirm: let passwordConfirm):
            return .patch
        case .updateMe:
            return .patch
        case .deleteMe:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(email: let email, password: let password):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .signUp(name: let name, email: let email, password: let password, passwordConfirm: let passwordConfirm):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .forgotPassword(email: let email):
            let parameters = ["email": email]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain
        case .resetPassword(token: _, password: let password, passwordConfirm: let passwordConfirm):
            let parameters = [
                "password": password,
                "passwordConfirm": passwordConfirm
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updateMyPassword(passwordCurrent: let passwordCurrent, password: let password, passwordConfirm: let passwordConfirm):
            let parameters = [
                "passwordCurrent": passwordCurrent,
                "password": password,
                "passwordConfirm": passwordConfirm
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updateMe:
            return .requestPlain
        case .deleteMe:
            return .requestPlain
        }
    }
}
