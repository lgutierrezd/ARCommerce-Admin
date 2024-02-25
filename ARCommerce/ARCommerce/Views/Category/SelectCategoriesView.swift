//
//  SelectCategoriesView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 12/2/24.
//

import SwiftUI

struct SelectCategoriesView: View {
    @Binding var selectedItems: Set<String>
    let categories: [ARCommerce.Category]
    @State var searchText: String = ""
    @State var categoriesFiltered: [ARCommerce.Category] = []
    
    var body: some View {
        List {
            TextField("Search Category", text: $searchText)
                .onChange(of: searchText) { _, newValue in
                    let regexPattern = "(?i)\(newValue)"
                    let regex = try! NSRegularExpression(pattern: regexPattern)
                    categoriesFiltered = categories.filter { category in
                        let name = category.name
                        let range = NSRange(location: 0, length: name.utf16.count)
                        return regex.firstMatch(in: name, options: [], range: range) != nil
                    }.filter({ $0.childs?.isEmpty ?? false }).sorted { $0.name < $1.name }
                }
            ForEach(categoriesFiltered) { category in
                SelectRow(
                    title: category.name,
                    isSelected: self.selectedItems.contains(category._id),
                    action: {
                        if self.selectedItems.contains(category._id) {
                            self.selectedItems.remove(category._id)
                        } else {
                            self.selectedItems.insert(category._id)
                        }
                    })
            }
        }
        .onAppear() {
            categoriesFiltered = categories.filter({ $0.childs?.isEmpty ?? false }).sorted { $0.name < $1.name }
        }
    }
}

//#Preview {
//    SelectCategoriesView(categories: [CategoryV1(_id: "1", name: "Uno"), CategoryV1(_id: "2", name: "Dos")])
//}
