//
//  SelectSuppliersView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct SelectSuppliersView: View {
    @Binding var selectedItems: Set<String>
    let suppliers: [Supplier]
    
    var body: some View {
        List {
            ForEach(suppliers) { supplier in
                SelectRow(
                    title: supplier.name,
                    isSelected: self.selectedItems.contains(supplier.id),
                    action: {
                        if self.selectedItems.contains(supplier.id) {
                            self.selectedItems.remove(supplier.id)
                        } else {
                            self.selectedItems.insert(supplier.id)
                        }
                    })
            }
        }
    }
}

//#Preview {
//    SelectSuppliersView()
//}
