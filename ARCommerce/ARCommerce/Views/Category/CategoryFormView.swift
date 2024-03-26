//
//  CategoryFormView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 7/2/24.
//

import SwiftUI

struct CategoryFormView: View {
    @State private var uuid = UUID()
    
    @Binding var selectedCategory: ARCommerce.Category?
    
    let action: () -> Void
    let isUpdate: Bool
    var body: some View {
        //UPDATE CATEGORY SECTION
        Section {
            TextField("Name", text: Binding(
                get: { self.selectedCategory?.name ?? "" },
                set: { self.selectedCategory?.name = $0 }
            ))
            Toggle("Is Main Category?", isOn: Binding(
                get: { self.selectedCategory?.isMain ?? false },
                set: { self.selectedCategory?.isMain = $0 }
            ))
            NavigationLink(destination: SelectCategoriesView(selectedCategory: $selectedCategory)) {
                Text("Select Childs")
            }
        } header: {
            HStack {
                if isUpdate {
                    Text("Update Category")
                } else {
                    Text("Add Category")
                }
                
                Spacer()
                Button(action: {
                    action()
                }, label: {
                    if isUpdate {
                        Image(systemName: "arrow.counterclockwise")
                    } else {
                        Image(systemName: "plus")
                    }
                    
                })
            }
        }
        
        // UPDATE CATEGORY SET UP SECTION
        Section {
//            ForEach(0..<selectedCategory?.setup?.count, id: \.self) { i in
//                HStack {
//                    if !$keys.isEmpty {
//                        TextField("Key", text: $keys[i])
//                        TextField("Value", text: $values[i])
//                    }
//                }
//            }
//            .onDelete(perform: { indexSet in
//                //let index = indexSet[indexSet.startIndex]
//                keys.remove(atOffsets: indexSet)
//                values.remove(atOffsets: indexSet)
//            })
        } header: {
//            HStack {
//                Text("Set up")
//                Spacer()
//                Button(action: {
//                    if numberOfSetUps > 1 {
//                        keys.removeLast()
//                        values.removeLast()
//                        numberOfSetUps -= 1
//                        uuid = UUID()
//                    }
//                }, label: {
//                    Image(systemName: "minus")
//                })
//                Button(action: {
//                    keys.append("")
//                    values.append("")
//                    numberOfSetUps += 1
//                    uuid = UUID()
//                }, label: {
//                    Image(systemName: "plus")
//                })
//            }
        }.id(uuid)
    }
}
