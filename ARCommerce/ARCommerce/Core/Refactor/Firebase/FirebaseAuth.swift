//
//  FirebaseAuth.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 8/1/24.
//

import Firebase

class FirebaseAuth {
    public class func loginUser(email: String, password: String) -> AuthDataResult? {
        var result: AuthDataResult?
        let semaphore = DispatchSemaphore(value: 0)

        Auth.auth().signIn(withEmail: email, password: password) { (completionResult, error) in
            result = completionResult
            semaphore.signal()
        }
        
        semaphore.wait()
        
        return result
    }
    
    deinit {
        print("FirebaseAuth deleted")
    }
}


