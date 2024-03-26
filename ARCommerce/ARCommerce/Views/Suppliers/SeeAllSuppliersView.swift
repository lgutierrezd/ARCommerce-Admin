//
//  SwiftUIView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct SeeAllSuppliersView: View {
    
    @StateObject var viewModel = SeeAllSuppliersViewModel()
    @State private var subscriptions: [AnyCancellable] = .init()
    @State var selectedSupplier: Supplier?
    @State var page: Int = 1
    @State var loading = false
    @State var showAlert = false
    @State var alertText = ""
    var body: some View {
        ZStack {
            List {
                Section {
                    TextField("Name", text: Binding(
                        get: { self.selectedSupplier?.name ?? "" },
                        set: { self.selectedSupplier?.name = $0 }
                    ))
                    TextField("Email", text: Binding(
                        get: { self.selectedSupplier?.email ?? "" },
                        set: { self.selectedSupplier?.email = $0 }
                    ))
                    TextField("Phone", text: Binding(
                        get: { self.selectedSupplier?.phone ?? "" },
                        set: { self.selectedSupplier?.phone = $0 }
                    ))
                } header: {
                    HStack {
                        Spacer()
                        Button(action: {
                            guard let supplier = selectedSupplier else { return }
                            updateSupplier(supplier: supplier)
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                        .disabled(selectedSupplier == nil ? true: false)
                    }
                }
                ForEach(viewModel.suppliers) { supplier in
                    HStack {
                        Text(supplier.name)
                        Text(supplier.email)
                    }
                    .task {
                        if supplier == viewModel.suppliers.last && !loading {
                            page += 1
                            getSuppliers()
                        }
                    }
                    .onTapGesture {
                        selectedSupplier = supplier
                    }
                }
                .onDelete(perform: { indexSet in
                    let index = indexSet[indexSet.startIndex]
                    let supplier = viewModel.suppliers[index]
                    viewModel.supplierService
                        .deleteSupplier(id: supplier.id)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished:
                                loading = false
                                viewModel.suppliers.remove(at: index)
                            case .failure(let error):
                                let (showAlert, alertMessage) = AREErrors.handleError(error)
                                self.showAlert = showAlert
                                self.alertText = alertMessage
                                loading = false
                            }
                        }, receiveValue: { value in
                            
                        })
                        .store(in: &subscriptions)
                    
                })
            }
            if loading {
                ProgressView()
            }
        }
        .navigationTitle("Update Suppliers")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            getSuppliers()
        }
    }
    
    fileprivate func updateSupplier(supplier: Supplier) {
        loading = true
        viewModel.supplierService
            .updateSupplier(supplier: supplier)
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
                
            })
            .store(in: &subscriptions)
    }
    
    fileprivate func getSuppliers() {
        loading = true
        viewModel.supplierService
            .getSuppliers(page: String(page), limit: "20")
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
            }, receiveValue: { value in
                value.data.data.forEach { newSupplier in
                    if !viewModel.suppliers.contains(where: { $0.id == newSupplier.id }) {
                        viewModel.suppliers.append(newSupplier)
                    }
                }
            })
            .store(in: &subscriptions)
    }
}

#Preview {
    SeeAllSuppliersView()
}
