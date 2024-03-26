//
//  AREErrors.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

struct AREErrors {
    static func handleError(_ error: Error) -> (showAlert: Bool, alertMessage: String) {
        switch error {
        case CustomError.credentialError:
            return (true, "\(CustomError.credentialError.localizedDescription)")
        case ARError.invalidURL:
            return (true, "URL inválida")
        case ARError.requestFailed(let underlyingError):
            return (true, "Error de solicitud: \(underlyingError.localizedDescription)")
        case ARError.decodingFailed(let underlyingError):
            return (true, "Error de decodificación: \(underlyingError.localizedDescription)")
        case ARError.invalidData:
            return (true, "Datos inválidos")
        default:
            return (true, "Error desconocido")
        }
    }
}

enum ARError: Error {
    case invalidURL
    case requestFailed(error: Error)
    case decodingFailed(error: Error)
    case invalidData
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


