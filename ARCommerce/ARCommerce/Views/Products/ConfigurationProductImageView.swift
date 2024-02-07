//
//  ConfigurationProductImageView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 15/1/24.
//

import SwiftUI

struct ConfigurationProductImageView: View {
    @Binding var selectedConfig: Int
    @Binding var selectedImagesByConfiguration: [UIImage]?

    var body: some View {
        if selectedImagesByConfiguration?.count ?? 0 > 0 {
            VStack {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10){
                            if let images = selectedImagesByConfiguration {
                                ForEach(images, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(8)
                                }
                            }
                            
                        }
                        .padding(10)
                    }
                    
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                            if let images = selectedImagesByConfiguration {
                                ForEach(images, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 130, height: 130)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(10)
                    }
                }
            }
            
            
        }
    }
}

//#Preview {
//    ConfigurationProductImageView()
//}
