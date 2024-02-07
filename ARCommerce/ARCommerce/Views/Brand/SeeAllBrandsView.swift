//
//  SeeAllBrandsViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct SeeAllBrandsView: View {
    @StateObject var seeAllBrandsViewModel = SeeAllBrandsViewModel()
    @State var selectedBrand: Brand?
    @State var name: String = ""
    
    var body: some View {
        List {
            Section {
                TextField("Name", text: $name)
            } header: {
                HStack {
                    Text("UPDATE BRAND")
                    
                    Spacer()
                    Button(action: {
                        Task {
                            if let brand = selectedBrand {
                                let newBrand = try await seeAllBrandsViewModel.updateBrand(id: brand.id, name: name)
                                
                                let item = seeAllBrandsViewModel.brands.first(where: { $0.id == newBrand.id })
                                item?.name = newBrand.name
                                
                            }
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                    .disabled(self.selectedBrand == nil ? true: false)
                }
            }
            
            ForEach(seeAllBrandsViewModel.brands) { brand in
                Text(brand.name)
                    .onTapGesture {
                        self.selectedBrand = brand
                        self.name = brand.name
                    }
            }
            .onDelete(perform: { indexSet in
                Task {
                    do {
                        let index = indexSet[indexSet.startIndex]
                        let brand = seeAllBrandsViewModel.brands[index]
                        let _ = try await seeAllBrandsViewModel.deleteBrand(brand: brand)
                    }
                }
            })
        }
        .onAppear() {
            Task {
                do {
                    try await seeAllBrandsViewModel.getAllBrands()
                } catch {
                    
                }
                
            }
            
        }
    }
}

#Preview {
    SeeAllBrandsView()
}
