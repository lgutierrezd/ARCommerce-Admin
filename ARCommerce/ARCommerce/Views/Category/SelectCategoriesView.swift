//
//  SelectCategoriesView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 12/2/24.
//

import SwiftUI
import Combine

struct SelectCategoriesView: View {
    @Binding var selectedCategory: ARCommerce.Category?
    @State var searchText: String = ""
    @State var categoriesFiltered: [ARCommerce.Category] = []
    
    @StateObject var seeAllCategoriesViewModel = SeeAllCategoriesViewModel()
    
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
    
    var body: some View {
        ZStack {
            List {
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
                ForEach(categoriesFiltered) { category in
                    SelectRow(
                        title: category.name,
                        isSelected: self.selectedCategory?.childs?.contains(category.id) ?? false,
                        action: {
                            if self.selectedCategory?.childs?.contains(category.id) ?? false {
                                if var childs = self.selectedCategory?.childs {
                                    childs.removeAll { $0 == category.id }
                                    self.selectedCategory?.childs = childs
                                }
                            } else {
                                self.selectedCategory?.childs?.insert(category.id, at: self.selectedCategory?.childs?.count ?? 0)
                            }
                        })
                    .task {
                        if category == categoriesFiltered.last && !isLoading {
                            page += 1
                            getCategories()
                        }
                    }
                }
            }
            if isLoading {
                Text("Loading Categories...")
                    .font(Font.caption)
                    .foregroundStyle(.gray)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear() {
            if selectedCategory?.childs == nil {
                selectedCategory?.childs = .init()
            }
            getCategories()
            
        }
    }
    
    func getCategories() {
        self.isLoading = true
        print("getCategories")
        seeAllCategoriesViewModel.categoryService.getCategories(page: String(page), limit: "20")
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
                page = value.data.data.count == 0 ? page - 1 : page
                value.data.data.forEach{ newCategory in
                    seeAllCategoriesViewModel.categories.append(newCategory)
                    categoriesFiltered = seeAllCategoriesViewModel.categories
                }
            })
            .store(in: &subscribers)
    }
}

//#Preview {
//    SelectCategoriesView(categories: [CategoryV1(_id: "1", name: "Uno"), CategoryV1(_id: "2", name: "Dos")])
//}
