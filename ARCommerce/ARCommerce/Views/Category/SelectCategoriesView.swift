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
    
    var body: some View {
        List {
            ForEach(categories) { category in
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
    }
}

struct SelectRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

//#Preview {
//    SelectCategoriesView(categories: [CategoryV1(_id: "1", name: "Uno"), CategoryV1(_id: "2", name: "Dos")])
//}
