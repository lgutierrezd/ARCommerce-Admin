//
//  LoginViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

class LoginViewModel {
    
    func login(email: String, password: String) async throws -> User {
        let coreUser = CoreUser()
        let user = try await coreUser.login(email: email, password: password)
        if user.eRole == .admin {
            let resultLogin = FirebaseAuth.loginUser(email: email, password: password)
            switch resultLogin {
            case .none:
                print("FirebaseAuth - Email Unavailable")
                return user
            case .some(let result):
                print("Some \(result.user.email ?? "Email Unavailable")")
            }
        }
        
        return user
    }
    

    deinit {
        print("LoginViewModel deleted")
    }
}

enum CustomError: Error {
    case notFound
    case credentialError
    case internalServerError(String)
    case invalidCase
    var localizedDescription: String {
            switch self {
            case .credentialError:
                return "Correo o Contraseña incorrectos."
            case .internalServerError(let value):
                return value
            case .notFound:
                return "Not found"
            case .invalidCase:
                return "Invalid case."
            }
        }
}
