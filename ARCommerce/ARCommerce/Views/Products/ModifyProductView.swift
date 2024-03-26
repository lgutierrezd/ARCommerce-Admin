//
//  ModifyProductView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import SwiftUI

struct ModifyProductView: View {
    @ObservedObject private var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    
    var body: some View {
        VStack {
            if let selectedProduct = globalDataManagerViewModel.selectedProduct {
                //ManageProductView(isUpdate: true, product: selectedProduct)
            }
       
        }

    }
}

#Preview {
    ModifyProductView()
}
