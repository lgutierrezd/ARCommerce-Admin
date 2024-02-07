//
//  AREErrors.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

struct AREErrors {
    static func handleLoginError(_ error: Error) -> (showAlert: Bool, alertMessage: String) {
        switch error {
        case CustomError.credentialError:
            return (true, "\(CustomError.credentialError.localizedDescription)")
        case NetworkError.invalidURL:
            return (true, "URL inválida")
        case NetworkError.requestFailed(let underlyingError):
            return (true, "Error de solicitud: \(underlyingError.localizedDescription)")
        case NetworkError.decodingFailed(let underlyingError):
            return (true, "Error de decodificación: \(underlyingError.localizedDescription)")
        case NetworkError.invalidData:
            return (true, "Datos inválidos")
        default:
            return (true, "Error desconocido")
        }
    }
}

