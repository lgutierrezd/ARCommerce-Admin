//
//  CategoryFormView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 7/2/24.
//

import SwiftUI

struct CategoryFormView: View {
    let pickerParentCategories: [ARCommerce.Category]
    @State private var uuid = UUID()
    @Binding var name: String
    @Binding var selectedParentCategory: ARCommerce.Category?
    @Binding var selectedCategory: ARCommerce.CategoryV1?
    @Binding var keys: [String]
    @Binding var values: [String]
    @Binding var numberOfSetUps: Int
    let action: () -> Void
    let isUpdate: Bool
    var body: some View {
        //UPDATE CATEGORY SECTION
        Section {
            TextField("Name", text: $name)
            Picker("Parent Category", selection: $selectedParentCategory) {
                Text("None").tag(nil as ARCommerce.CategoryV1?)
                ForEach(pickerParentCategories, id: \.self) { category in
                    Text(category.name).tag(category as ARCommerce.Category?)
                }
            }
            .onChange(of: selectedCategory ?? ARCommerce.CategoryV1() , { _,newValue in
                if let parent = pickerParentCategories.first(where: { $0._id == newValue.parent?._id }) {
                    selectedParentCategory = parent
                } else {
                    selectedParentCategory = nil
                }
            })
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
            ForEach(0..<numberOfSetUps, id: \.self) { i in
                HStack {
                    if !$keys.isEmpty {
                        TextField("Key", text: $keys[i])
                        TextField("Value", text: $values[i])
                    }
                }
            }
            .onDelete(perform: { indexSet in
                //let index = indexSet[indexSet.startIndex]
                keys.remove(atOffsets: indexSet)
                values.remove(atOffsets: indexSet)
            })
        } header: {
            HStack {
                Text("Set up")
                Spacer()
                Button(action: {
                    if numberOfSetUps > 1 {
                        keys.removeLast()
                        values.removeLast()
                        numberOfSetUps -= 1
                        uuid = UUID()
                    }
                }, label: {
                    Image(systemName: "minus")
                })
                Button(action: {
                    keys.append("")
                    values.append("")
                    numberOfSetUps += 1
                    uuid = UUID()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }.id(uuid)
    }
}
