//
//  LoginView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = "luchogd26@hotmail.com"
    @State private var password: String = "pass1234"
    
    @EnvironmentObject var appSettings: AppSettings
    
    let loginVM = LoginViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("Usuario", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Contraseña", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Iniciar sesión") {
                Task {
                    do {
                        let user = try await loginVM.login(email: email, password: password)
                        appSettings.user = user
                        appSettings.isLoggedIn = true
                        
                        appSettings.saveUser()
                    } catch {
                        let (showAlert, alertMessage) = AREErrors.handleLoginError(error)
                        self.showAlert = showAlert
                        self.alertMessage = alertMessage
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
        
    }
}

#Preview {
    LoginView()
}
