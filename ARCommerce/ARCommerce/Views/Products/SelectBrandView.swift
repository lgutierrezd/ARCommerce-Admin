//
//  SelectBrandView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 21/2/24.
//

import SwiftUI

struct SelectBrandView: View {
    @Binding var selectedBrand: Brand?
    let brands: [ARCommerce.Brand]
    
    var body: some View {
        List {
            ForEach(brands) { brand in
                SelectRow(
                    title: brand.name,
                    isSelected: self.selectedBrand == brand, action: {
                        self.selectedBrand = brand
                    })
            }
        }
    }
}

//#Preview {
//    SelectBrandView()
//}
