//
//  FormLocationView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 20/2/24.
//

import SwiftUI

struct FormLocationView: View {
    @Binding var location: Location?
    
    var body: some View {
        TextField("Location Name", text: Binding(
            get: { self.location?.locationName ?? "" },
            set: { self.location?.locationName = $0 }
        ))
        TextField("Latitude", text: Binding(
            get: { self.location?.lat ?? "" },
            set: { self.location?.lat = $0 }
        ))
        TextField("Longitude", text: Binding(
            get: { self.location?.lon ?? "" },
            set: { self.location?.lon = $0 }
        ))
    }
}

#Preview {
    FormLocationView(location: .constant(nil))
}
