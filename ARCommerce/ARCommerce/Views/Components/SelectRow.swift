//
//  SelectedRow.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

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


#Preview {
    SelectRow(title: "Thing", isSelected: true, action: {})
}
