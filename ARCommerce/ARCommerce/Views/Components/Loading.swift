//
//  Loading.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 16/1/24.
//

import SwiftUI

struct Loading: View {
    @Binding var isLoading: Bool
    @State private var isRotating = 0.0
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .rotationEffect(.degrees(isRotating))
            .onAppear {
                withAnimation(.linear(duration: 3)
                    .repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
            }
            .frame(width: 500, height: 500)
    }
}

#Preview {
    Loading(isLoading: .constant(true))
}
