//
//  ConfigurationProductImageView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct ConfigurationProductImageView: View {
//    @ObservedObject var manageProductViewModel: ManageProductViewModel
    @Binding var selectedConfig: Int

    var body: some View {
        ZStack {
//            if !manageProductViewModel.listConfigurations.isEmpty {
//                VStack {
//                    if UIDevice.current.userInterfaceIdiom == .pad {
//                        ScrollView(.vertical) {
//                            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10){
//                                ForEach(manageProductViewModel.listConfigurations[selectedConfig].uimages, id: \.self) { image in
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 200, height: 200)
//                                        .cornerRadius(8)
//                                }
//                                
//                            }
//                            .padding(10)
//                        }
//                        
//                    } else if UIDevice.current.userInterfaceIdiom == .phone {
//                        ScrollView(.vertical) {
//                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
//                                ForEach(manageProductViewModel.listConfigurations[selectedConfig].uimages, id: \.self) { image in
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 130, height: 130)
//                                        .cornerRadius(8)
//                                }
//                            }
//                            .padding(10)
//                        }
//                    }
//                }
//                
//                
//            }
//            if manageProductViewModel.isLoadingImages {
//                VStack {
//                    ProgressView()
//                }
//            }
        }
    }
}

//#Preview {
//    ConfigurationProductImageView()
//}
