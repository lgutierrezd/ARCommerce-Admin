//
//  AddSupplierView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct AddSupplierView: View {
    var addSupplierViewModel = AddSupplierViewModel()
    @State var supplier: Supplier = Supplier(id: "", name: "", email: "", phone: "")
    @State private var subscriptions: [AnyCancellable] = .init()
    @State var loading = false
    @State var showAlert = false
    @State var alertText = ""
    var body: some View {
        ZStack {
            List {
                Section {
                    TextField("Name", text: $supplier.name)
                    TextField("Email", text: $supplier.email)
                    TextField("Phone", text: $supplier.phone)
                } header: {
                    HStack {
                        Spacer()
                        Button(action: {
                            addSupplier()
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
    
    
    fileprivate func addSupplier() {
        loading = true
        addSupplierViewModel.supplierService
            .addSupplier(supplier: self.supplier)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    loading = false
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertText = alertMessage
                    loading = false
                }
            }, receiveValue: { _ in
                self.supplier = Supplier(id: "", name: "", email: "", phone: "")
            })
            .store(in: &subscriptions)
    }
}

#Preview {
    AddSupplierView()
}
