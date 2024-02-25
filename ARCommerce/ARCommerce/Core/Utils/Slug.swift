//
//  Slug.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 24/2/24.
//

import Foundation

func createSlug(from text: String) -> String {
    var slug = text.lowercased()
    
    // Reemplazar caracteres especiales y acentos
    let characterMap: [Character: Character] = [
        "á": "a", "é": "e", "í": "i", "ó": "o", "ú": "u",
        "ü": "u", "ñ": "n", "ç": "c", " ": "-"
    ]
    slug = String(slug.map { characterMap[$0] ?? $0 })
    
    // Eliminar cualquier carácter no deseado
    let allowedCharacters = Set("abcdefghijklmnopqrstuvwxyz0123456789-_")
    slug = String(slug.filter { allowedCharacters.contains($0) })
    
    // Eliminar múltiples guiones bajos consecutivos
    slug = slug.replacingOccurrences(of: "--+", with: "-", options: .regularExpression)
    
    // Eliminar guiones bajos al principio y al final
    if slug.first == "-" { slug.removeFirst() }
    if slug.last == "-" { slug.removeLast() }
    
    return slug
}
