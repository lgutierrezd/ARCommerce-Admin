//
//  FirebaseStorage.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 8/1/24.
//

import FirebaseAuth
import FirebaseStorage
import UIKit

class FirebaseStorage {
    public class func persistImageToStorage(path: String, name: String ,image: UIImage) async throws -> String? {
        let ref = Storage.storage().reference(withPath: "\(path)/\(name)")
        guard let imageData = image.jpegData(compressionQuality: 0.9) else { return nil }

        return await withCheckedContinuation { continuation in
            ref.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    continuation.resume(throwing: error as! Never)
                    return
                }

                ref.downloadURL { url, error in
                    if let error = error {
                        continuation.resume(throwing: error as! Never)
                    } else if let urlString = url?.absoluteString {
                        continuation.resume(returning: urlString)
                    } else {
                        continuation.resume(returning: nil)
                    }
                }
            }
        }
    }
    
    public class func deleteImageFromStorage(path: String, name: String) async throws {
        let ref = Storage.storage().reference(withPath: "\(path)/\(name)")

        return try await withCheckedThrowingContinuation { continuation in
            ref.delete { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}

