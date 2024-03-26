//
//  LoginView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var loginVM = LoginViewModel()
    @State private var subscribers = Set<AnyCancellable>()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Usuario", text: $loginVM.email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Contraseña", text: $loginVM.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Iniciar sesión") {
                    Task {
                        isLoading = true
                        loginVM.userService.login(email: loginVM.email, password: loginVM.password).sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                isLoading = false
                            case .failure(let error):
                                let (showAlert, alertMessage) = AREErrors.handleError(error)
                                self.showAlert = showAlert
                                self.alertMessage = alertMessage
                            }
                            
                        }, receiveValue: { value in
                            appSettings.user = value.data.user
                            appSettings.token = value.token
                            appSettings.isLoggedIn = true
                            
                            appSettings.saveUser()
                        })
                        .store(in: &subscribers)
                    }
                }
                .disabled(isLoading)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            if isLoading {
                ProgressView()
            }
        }
       
        
    }
}

#Preview {
    LoginView()
}
