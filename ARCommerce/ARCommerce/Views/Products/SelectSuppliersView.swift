//
//  SelectSuppliersView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI
//
//struct SelectSuppliersView: View {
//    @Binding var selectedItems: Set<String>
//    let suppliers: [Supplier]
//    @State var searchText: String = ""
//    @State var suppliersFiltered: [Supplier] = []
//    
//    var body: some View {
//        List {
//            TextField("Search Suppliers", text: $searchText)
//                .onChange(of: searchText) { _, newValue in
//                    let regexPattern = "(?i)\(newValue)"
//                    let regex = try! NSRegularExpression(pattern: regexPattern)
//                    suppliersFiltered = suppliers.filter { sup in
//                        let name = sup.name
//                        let range = NSRange(location: 0, length: name.utf16.count)
//                        return regex.firstMatch(in: name, options: [], range: range) != nil
//                    }.sorted { $0.name < $1.name }
//                }
//            ForEach(suppliersFiltered) { supplier in
//                SelectRow(
//                    title: supplier.name,
//                    isSelected: self.selectedItems.contains(supplier.id),
//                    action: {
//                        if self.selectedItems.contains(supplier.id) {
//                            self.selectedItems.remove(supplier.id)
//                        } else {
//                            self.selectedItems.insert(supplier.id)
//                        }
//                    })
//            }
//        }
//        .onAppear() {
//            suppliersFiltered = suppliers.sorted { $0.name < $1.name }
//        }
//    }
//}
//
////#Preview {
////    SelectSuppliersView()
////}
