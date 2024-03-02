//
//  AddBrandView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct AddBrandView: View {
    var addBrandViewModel = AddBrandViewModel()
    @State var name = ""
    var body: some View {
        List {
            Section {
                TextField("Name", text: $name)
            } header: {
                HStack {
                    Text("ADD BRAND")
                    
                    Spacer()
                    Button(action: {
                        Task {
                            do {
                                let _ = try await addBrandViewModel.addBrand(name: name)
                                name = ""
                            } catch {
                                
                            }
                            
                        }
                        
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .disabled(self.name.isEmpty ? true: false)
                }
            }
        }
        .navigationTitle("Add Brand")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    AddBrandView()
}
