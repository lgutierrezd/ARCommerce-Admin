//
//  FormLocationView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct FormLocationView: View {
    @Binding var locationName: String
    @Binding var lat: String
    @Binding var lon: String
    
    var body: some View {
        TextField("Location Name", text: $locationName)
        TextField("Latitude", text: $lat)
        TextField("Longitude", text: $lon)
    }
}

#Preview {
    FormLocationView(locationName: .constant("San Jose"), lat: .constant("10.433534"), lon: .constant("-83.453453"))
}
