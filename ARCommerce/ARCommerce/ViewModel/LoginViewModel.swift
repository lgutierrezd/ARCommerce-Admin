//
//  LoginViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    let userService: UserServiceType
    @Published var email: String = "luchogd26@hotmail.com"
    @Published var password: String = "pass1234"
    
    init(userService: UserServiceType = UserService()) {
        self.userService = userService
    }
    
}
