//
//  AddBrandView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct AddBrandView: View {
    private var addBrandViewModel = AddBrandViewModel()
    @State private var subscriptions: [AnyCancellable] = .init()
    @State private var brand: Brand = Brand(id: "1", name: "")
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    var body: some View {
        ZStack {
            List {
                Section {
                    TextField("Name", text: $brand.name)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                } header: {
                    HStack {
                        Text("ADD BRAND")
                        
                        Spacer()
                        Button(action: addBrand, label: {
                            Image(systemName: "plus")
                        })
                        .disabled(self.brand.name.isEmpty ? true: false)
                    }
                }
            }
            if isLoading {
                ProgressView()
            }
        }
        .navigationTitle("Add Brand")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func addBrand() {
        isLoading = true
        addBrandViewModel.brandService
            .addBrand(brand: brand)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    isLoading = false
                    brand = Brand(id: "1", name: "")
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                    isLoading = false
                }
            }, receiveValue: { value in
                
            })
            .store(in: &subscriptions)
    }
}

#Preview {
    AddBrandView()
}
