//
//  SelectBrandView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 21/2/24.
//

import SwiftUI
//
//struct SelectBrandView: View {
//    @Binding var selectedBrand: Set<String>
//    let brands: [ARCommerce.Brand]
//    @State var brandsFiltered: [ARCommerce.Brand] = []
//    @State var searchText = ""
//    
//    var body: some View {
//        List {
//            TextField("Search Brand", text: $searchText)
//                .onChange(of: searchText) { _, newValue in
//                    let regexPattern = "(?i)\(newValue)"
//                    let regex = try! NSRegularExpression(pattern: regexPattern)
//                    brandsFiltered = brands.filter { br in
//                        let name = br.name
//                        let range = NSRange(location: 0, length: name.utf16.count)
//                        return regex.firstMatch(in: name, options: [], range: range) != nil
//                    }.sorted { $0.name < $1.name }
//                }
//            ForEach(brandsFiltered) { brand in
//                SelectRow(
//                    title: brand.name,
//                    isSelected: self.selectedBrand.contains(brand.id), action: {
//                        if selectedBrand.contains(brand.id) {
//                            selectedBrand.remove(brand.id)
//                        } else {
//                            self.selectedBrand.removeAll()
//                            self.selectedBrand.insert(brand.id)
//                        }
//                        
//                    })
//            }
//        }
//        .onAppear() {
//            brandsFiltered = brands.sorted { $0.name < $1.name }
//        }
//    }
//}

//#Preview {
//    SelectBrandView()
//}
