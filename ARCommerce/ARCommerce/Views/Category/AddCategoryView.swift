//
//  AddCategoryView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import SwiftUI
import Combine

struct AddCategoryView: View {
    @ObservedObject var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    var addCategoryViewModel = AddCategoryViewModel()
    @State private var subscriptions: Set<AnyCancellable> = .init()
    @State var selectedCategory: ARCommerce.Category? = ARCommerce.Category(_id: "", name: "", childs: .init())
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    var body: some View {
        NavigationStack {
            List {
                CategoryFormView(selectedCategory: $selectedCategory, action: addCategory, isUpdate: false)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Add Category")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func addCategory() {
        guard let category = self.selectedCategory else {
            return
        }
        addCategoryViewModel.categoryService.addCategory(category: category)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.selectedCategory = ARCommerce.Category(_id: "", name: "", childs: .init())
                case .failure(let error):
                    let (showAlert, alertMessage) = AREErrors.handleError(error)
                    self.showAlert = showAlert
                    self.alertMessage = alertMessage
                }
            }, receiveValue: { value in
                
            })
            .store(in: &subscriptions)
    }
}

//#Preview {
//    AddCategoryView()
//}
