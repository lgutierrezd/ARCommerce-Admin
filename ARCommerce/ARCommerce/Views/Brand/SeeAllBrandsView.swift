//
//  SeeAllBrandsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct SeeAllBrandsView: View {
    @StateObject private var seeAllBrandsViewModel = SeeAllBrandsViewModel()
    @State private var subscriptions: [AnyCancellable] = .init()
    @State private var selectedBrand: Brand?
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State var page: Int = 1
    var body: some View {
        ZStack {
            List {
                Section {
                    TextField("Name", text: Binding(
                        get: { self.selectedBrand?.name ?? "" },
                        set: { self.selectedBrand?.name = $0 }
                    ))
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                } header: {
                    HStack {
                        Text("UPDATE BRAND")
                        
                        Spacer()
                        Button(action: {
                            updateBrand()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                        .disabled(self.selectedBrand == nil ? true: false)
                    }
                }
                .disabled(isLoading)
                
                ForEach(seeAllBrandsViewModel.brands) { brand in
                    Text(brand.name)
                        .onTapGesture {
                            self.selectedBrand = brand
                        }
                }
                .onDelete(perform: { indexSet in
                    deleteBrand(indexSet)
                })
            }
            if isLoading {
                ProgressView()
            }
        }
        .navigationTitle("See all Brands")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            getBrands()
        }
    }
    
    func deleteBrand(_ indexSet: IndexSet) {
        let index = indexSet[indexSet.startIndex]
        let brand = seeAllBrandsViewModel.brands[index]
        self.isLoading = true
        seeAllBrandsViewModel.brandService
            .deleteBrand(id: brand.id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                    seeAllBrandsViewModel.brands.removeAll(where: { $0.id == brand.id })
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &subscriptions)
    }
    
    func getBrands() {
        isLoading = true
        seeAllBrandsViewModel.brandService
            .getBrands(page: String(page), limit: "20")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                seeAllBrandsViewModel.brands = value.data.data
            })
            .store(in: &subscriptions)
    }
    
    func updateBrand() {
        if let brand = selectedBrand {
            isLoading = true
            seeAllBrandsViewModel.brandService
                .updateBrand(brand: brand)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                    isLoading = false
                    case .failure(let error):
                        let (showAlert, alertMessage) = AREErrors.handleError(error)
                        self.showAlert = showAlert
                        self.alertMessage = alertMessage
                    }
                }, receiveValue: { value in
                    
                })
                .store(in: &subscriptions)
            
        }
    }
}

#Preview {
    SeeAllBrandsView()
}
