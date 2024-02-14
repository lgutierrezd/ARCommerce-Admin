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
    @State private var selectedChildsCategoryId: Set<String> = Set<String>()
    
    @State private var keys: [String] = Array(repeating: "", count: 0)
    @State private var values: [String] = Array(repeating: "", count: 0)
    @State private var isMain: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                CategoryFormView(
                    pickerParentCategories: globalDataManagerViewModel.categories,
                    name: $name,
                    selectedChildsCategoryId: $selectedChildsCategoryId,
                    selectedCategory: $selectedCategory ,
                    keys: $keys,
                    values: $values,
                    numberOfSetUps: $numberOfSetUps, isMain: $isMain,
                    action: {
                        addCategory()
                    }, isUpdate: false
                )
            }
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
                let selectedChilds = Array<String>(selectedChildsCategoryId)
                let _ = try await addCategoryViewModel.addCategory(name:name, selectedChilds: selectedChilds, setup: setup)
                selectedCategory = nil
                name = ""
                keys = []
                values = []
                isMain = false
            } catch {
                
            }
            
        }
    }
}

//#Preview {
//    AddCategoryView()
//}
