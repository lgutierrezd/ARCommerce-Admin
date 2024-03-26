//
//  UserService.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/24/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func login(email: String, password: String) -> AnyPublisher<UserResponse, Error>
}

struct UserService: UserServiceType {
    
    private let requester: NetworkingRequesterType
    
    init(requester: NetworkingRequesterType = NetworkingRequester()) {
        self.requester = requester
    }
    
    func login(email: String, password: String) -> AnyPublisher<UserResponse, Error> {
        requester.get(target: UserTarget.login(email: email, password: password))
    }
}
