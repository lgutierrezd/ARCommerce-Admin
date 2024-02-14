//
//  SeeAllCategoriesView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI

struct SeeAllCategoriesView: View {
    @StateObject var seeAllCategoriesViewModel = SeeAllCategoriesViewModel()
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    @State var page: Int = 1 {
        willSet {
            if newValue < 0 {
                page = 1
            }
        }
    }
    
    @State private var uuid = UUID()
    @State var name = ""
    @State var numberOfSetUps: Int = 0
    @State private var selectedCategory: ARCommerce.CategoryV1?
    @State private var selectedChildsCategoryId: Set<String> = Set<String>()
    @State private var keys: [String] = Array(repeating: "", count: 0)
    @State private var values: [String] = Array(repeating: "", count: 0)
    @State private var isMain: Bool = false
    @State private var pickerParentCategories: [ARCommerce.Category] = []
    
    var body: some View {
        NavigationStack {
            List {
                CategoryFormView(
                    pickerParentCategories: pickerParentCategories,
                    name: $name,
                    selectedChildsCategoryId: $selectedChildsCategoryId,
                    selectedCategory: $selectedCategory ,
                    keys: $keys,
                    values: $values,
                    numberOfSetUps: $numberOfSetUps, isMain: $isMain,
                    action: {
                        updateCategory()
                    }, isUpdate: true
                )
                
                
                //LIST OF CATEGORIES
                Section {
                    ForEach(seeAllCategoriesViewModel.categories) { cat in
                        HStack {
                            if let isMain = cat.isMain {
                                Text(cat.name)
                                if isMain {
                                    Text("Is Main")
                                        .foregroundStyle(Color.red)
                                }
                            } else {
                                Text(cat.name)
                            }
                            
                        }
                        .onTapGesture {
                            selectedCategory = nil
                            selectedCategory = cat
                            selectedChildsCategoryId = Set(cat.childs ?? [])
                            name = cat.name
                            isMain = cat.isMain ?? false
                            numberOfSetUps = selectedCategory?.setup?.count ?? 0
                            keys.removeAll()
                            values.removeAll()
                            if let setup = cat.setup {
                                for dictionary in setup {
                                    keys.append(dictionary.key)
                                    values.append(dictionary.value)
                                }
                            }
                        }
                    }
                    .onDelete(perform: { indexSet in
                        let index = indexSet[indexSet.startIndex]
                        let categoryToDelete = seeAllCategoriesViewModel.categories[index]
                        Task {
                            do {
                                let _ = try await seeAllCategoriesViewModel.deleteCategory(category: categoryToDelete)
                            } catch {
                                
                            }
                            
                        }
                        
                    })
                } header: {
                    HStack {
                        Spacer()
                        Button(action: {
                            page -= 1
                            getCategories()
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        .disabled(page == 1 ? true : false)
                        Button(action: {
                            page += 1
                            getCategories()
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                        .disabled(seeAllCategoriesViewModel.categories.count < 8)
                    }
                }
                
            }
        }
        .onAppear() {
            getCategories()
        }
    }
    
    fileprivate func updateCategory() {
        Task {
            var setup: [Setup] = []
            keys.enumerated().forEach { index, key in
                setup.append(Setup(_id: String(index), key: key, value: values[index]))
            }
            do {
                selectedCategory?.childs = Array<String>(selectedChildsCategoryId)
                selectedCategory?.setup = setup
                selectedCategory?.isMain = isMain
                if let selectedCategory {
                    let _ = try await seeAllCategoriesViewModel.updateCategory(category: selectedCategory)
                    
                }
                name = ""
                keys = []
                values = []
                isMain = false
                selectedCategory = nil
            } catch {
                
            }
            
        }
    }
    
    fileprivate func getCategories() {
        
        Task {
            do {
                try globalDataManagerViewModel.getInitialData()
                pickerParentCategories = globalDataManagerViewModel.categories
                try await seeAllCategoriesViewModel.getAllCategories(page: page, limit: 20)
            } catch {
                
            }
        }
    }
}
//
//#Preview {
//    SeeAllCategoriesView()
//}


