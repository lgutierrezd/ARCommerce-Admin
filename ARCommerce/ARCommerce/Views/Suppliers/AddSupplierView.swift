//
//  AddSupplierView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct AddSupplierView: View {
    @StateObject var addSupplierViewModel = AddSupplierViewModel()
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var loading = false
    @State var showAlert = false
    @State var alertText = ""
    var body: some View {
        VStack {
            List {
                Section {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Phone", text: $phone)
                } header: {
                    HStack {
                        Spacer()
                        Button(action: {
                            Task {
                                do {
                                    let _ = try await addSupplierViewModel.addSupplier(name:name, email:email, phone:phone)
                                    email = ""
                                    name = ""
                                    phone = ""
                                } catch {
                                    handleError(error)
                                }
                                
                            }
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            }
            if loading {
                ProgressView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertText))
        }
        .navigationTitle("Add Supplier")
        .navigationBarTitleDisplayMode(.large)
    }
    
    fileprivate func handleError(_ error: Error) {
        if let customError = error as? CustomError {
            switch customError {
            case .credentialError:
                alertText = "An error has occurred, try again."
                showAlert = true
            case .internalServerError(let value):
                alertText = value
                showAlert = true
            case .notFound:
                alertText = "Product do not exits."
                showAlert = true
            case .invalidCase:
                alertText = "Something is going wrong."
                showAlert = true
            }
            
        } else {
//            print(error.localizedDescription)
        }
        self.loading = false
    }
}

#Preview {
    AddSupplierView()
}
