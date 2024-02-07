//
//  AddCategoryView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    var addCategoryViewModel = AddCategoryViewModel()
    
    @State private var uuid = UUID()
    @State var name = ""
    @State var numberOfSetUps: Int = 0
    @State private var selectedCategory: ARCommerce.CategoryV1?
    @State private var selectedParentCategory: ARCommerce.Category?
    
    @State private var keys: [String] = Array(repeating: "", count: 0)
    @State private var values: [String] = Array(repeating: "", count: 0)
    
    var body: some View {
        List {
            CategoryFormView(
                pickerParentCategories: globalDataManagerViewModel.categories,
                name: $name,
                selectedParentCategory: $selectedParentCategory,
                selectedCategory: $selectedCategory ,
                keys: $keys,
                values: $values,
                numberOfSetUps: $numberOfSetUps,
                action: {
                    addCategory()
                }, isUpdate: false
            )
        }
        .navigationTitle("Add Category")
        .navigationBarTitleDisplayMode(.large)
        
    }
    
    func addCategory() {
        Task {
            var setup: [Setup] = []
            keys.enumerated().forEach { index, key in
                setup.append(Setup(_id: String(index), key: key, value: values[index]))
            }
            do {
                let selectedParent = CategoryV1(_id: selectedParentCategory?._id ?? "", name: selectedParentCategory?.name ?? "")
                let _ = try await addCategoryViewModel.addCategory(name:name, selectedParent: selectedParent, setup: setup)
                selectedCategory = nil
                name = ""
                keys = []
                values = []
            } catch {
                
            }
            
        }
    }
}

#Preview {
    AddCategoryView()
}
