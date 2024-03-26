//
//  SeeAllCategoriesView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct SeeAllCategoriesView: View {
    @StateObject var seeAllCategoriesViewModel = SeeAllCategoriesViewModel()
    @State var searchText: String = ""
    @State var categoriesFiltered: [ARCommerce.Category] = []
    @State private var subscribers = Set<AnyCancellable>()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    @State var page: Int = 1 {
        willSet {
            if newValue < 0 {
                page = 1
            }
        }
    }
    
    @State private var uuid = UUID()
    
    @State private var selectedCategory: ARCommerce.Category?
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    CategoryFormView(selectedCategory: $selectedCategory, action: {
                        updateCategory()
                    }, isUpdate: true)
                    
                    searchTextField
                    
                    list
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                if isLoading {
                    ProgressView()
                }
            }
            
        }
        .onAppear() {
            getCategories()
        }
    }
    
    var searchTextField: some View {
        TextField("Search Category", text: $searchText)
            .onChange(of: searchText) { _, newValue in
                let regexPattern = "(?i)\(newValue)"
                let regex = try! NSRegularExpression(pattern: regexPattern)
                categoriesFiltered = seeAllCategoriesViewModel.categories.filter { category in
                    let name = category.name
                    let range = NSRange(location: 0, length: name.utf16.count)
                    return regex.firstMatch(in: name, options: [], range: range) != nil
                }.filter({ $0.childs?.isEmpty ?? false }).sorted { $0.name < $1.name }
            }
    }
    
    var list: some View {
        ForEach(categoriesFiltered) { cat in
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
            .task {
                if cat == seeAllCategoriesViewModel.categories.last && !isLoading {
                    page += 1
                    getCategories()
                }
            }
            
            .onTapGesture {
                selectedCategory = nil
                selectedCategory = cat
            }
        }
        .onDelete(perform: { indexSet in
            let index = indexSet[indexSet.startIndex]
            let categoryToDelete = seeAllCategoriesViewModel.categories[index]
            deleteCategory(id: categoryToDelete.id)
        })
    }
    
    fileprivate func deleteCategory(id: String) {
        self.isLoading = true
        seeAllCategoriesViewModel.categoryService.deleteCategory(id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                    seeAllCategoriesViewModel.categories.removeAll(where: { $0.id == id })
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                
            })
            .store(in: &subscribers)
    }
    
    fileprivate func updateCategory() {
        self.isLoading = true
        guard let category = self.selectedCategory else { return }
        seeAllCategoriesViewModel.categoryService.updateCategory(category: category)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                self.selectedCategory = value.data.data
            })
            .store(in: &subscribers)
    }
    
    fileprivate func getCategories() {
        self.isLoading = true
        seeAllCategoriesViewModel.categoryService.getCategories(page: String(page), limit: "20").sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                let (showAlert, alertMessage) = AREErrors.handleError(error)
                self.showAlert = showAlert
                self.alertMessage = alertMessage
            }
        }, receiveValue: { value in
            page = value.data.data.count == 0 ? page - 1 : page
            value.data.data.forEach{ newCategory in
                seeAllCategoriesViewModel.categories.append(newCategory)
                categoriesFiltered = seeAllCategoriesViewModel.categories
            }
        })
        .store(in: &subscribers)
    }
}

#Preview {
    SeeAllCategoriesView()
}


