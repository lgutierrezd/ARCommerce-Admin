//
//  ContentView.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        Group {
            if appSettings.isLoggedIn {
                MainMenu()
            } else {
                LoginView()
            }
        }
        
    }
}

struct MainMenu: View {
    @EnvironmentObject var appSettings: AppSettings
    
    @StateObject private var menuViewModel = MenuViewModel()
    @ObservedObject private var globalDataManagerViewModel = GlobalDataManagerViewModel.shared
    
    @State private var selectedCategoryId: MenuItem.ID?
    @State private var selectedItem: MenuItem?
    
    var body: some View {
        NavigationSplitView {
            List(MenuViewModel.mainMenuItems, selection: $selectedCategoryId) { item in
                HStack {
                    Text(item.name)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                }
            }
            .navigationTitle("Administrator")
        } content: {
            if let selectedCategoryId,
               let subMenuItems = MenuViewModel.subMenuItems(for: selectedCategoryId) {
                List(subMenuItems, selection: $selectedItem) { item in
                    NavigationLink(value: item) {
                        HStack {
                            Text(item.name)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                
            } else {
                Text("Please select a menu item")
            }
            
        } detail: {
            if let selectedItem {
                switch selectedCategoryId {
                case 0:
                    if selectedItem.id == 0 {
                        Text("Account")
                    } else {
                        Text("Settings")
                    }
                case 1:
                    if selectedItem.id == 0 {
                        AddAndUpdateProductView(isUpdate: false, selectedCategories: Set<String>())
                    } else if selectedItem.id == 1 {
                        ModifyProductView()
                    } else {
                        SeeAllProductsView()
                    }
                case 2:
                    if selectedItem.id == 0 {
                        Text(selectedItem.name)
                    } else {
                        Text(selectedItem.name)
                    }
                case 3:
                    if selectedItem.id == 0 {
                        AddBrandView()
                    } else {
                        SeeAllBrandsView()
                    }
                case 4:
                    if selectedItem.id == 0 {
                        AddCategoryView()
                    } else {
                        SeeAllCategoriesView()
                    }
                case 5:
                    if selectedItem.id == 0 {
                        AddSupplierView()
                    } else {
                        SeeAllSuppliersView()
                    }
                case nil:
                    Text("None")
                case .some(_):
                    Text("None")
                }
                
            } else {
                Text("Please select an item")
            }
        }
        .onChange(of: globalDataManagerViewModel.selectedItem) { _,newValue in
            if newValue != nil {
                self.selectedItem = newValue
                globalDataManagerViewModel.selectedItem = nil
            }
        }
        .onChange(of: selectedCategoryId) { _, newValue in
            appSettings.selectedCategoryId = newValue
            appSettings.saveMenuStateCategoryId()
        }
        .onChange(of: selectedItem) { _, newValue in
            appSettings.selectedItem = newValue
            appSettings.saveMenuStateItem()
        }
        .onAppear() {
            appSettings.loadMenuState()
            self.selectedCategoryId = appSettings.selectedCategoryId
            self.selectedItem = appSettings.selectedItem
        }
        .onAppear() {
            Task {
                do {
                    try await menuViewModel.getSaveInitialData()
                    try globalDataManagerViewModel.getInitialData()
                } catch {
                    print("Error loading pickers: \(error)")
                }
            }
        }
        
    }
}

#Preview {
    MainMenu()
}


