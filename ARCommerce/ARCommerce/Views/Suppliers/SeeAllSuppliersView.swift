//
//  SwiftUIView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct SeeAllSuppliersView: View {
    
    @StateObject var viewModel = SeeAllSuppliersViewModel()
    
    @State var selectedSupplier: Supplier?
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    var body: some View {
        
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
                            if let supplier = selectedSupplier {
                                let supplier = try await viewModel.updateSupplier(id: supplier.id, supplier: Supplier(id: supplier.id, name: name, email: email, phone: phone))
                                let sup = viewModel.suppliers.filter {
                                    $0.id == supplier.id
                                }.first
                                sup!.name = supplier.name
                                sup!.email = supplier.email
                                sup!.phone = supplier.phone
                                
                            }
                        }
                            
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
                .onTapGesture {
                    selectedSupplier = supplier
                    name = supplier.name
                    email = supplier.email
                    phone = supplier.phone
                }
            }
            .onDelete(perform: { indexSet in
                let index = indexSet[indexSet.startIndex]
                Task {
                    let idS: String = viewModel.suppliers[index].id
                    let _ = try await viewModel.deleteSuppliers(id: idS)
                }
                
            })
        }
        .navigationTitle("Update Suppliers")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            Task {
                try await viewModel.getSuppliers()
            }
           
        }
    }
}

#Preview {
    SeeAllSuppliersView()
}
