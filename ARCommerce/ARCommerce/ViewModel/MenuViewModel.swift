//
//  MenuViewModel.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 21/12/23.
//

import Foundation
import Observation

@Observable class MenuViewModel: ObservableObject {
    static let mainMenuItems = {
        let userAccountItems = [ MenuItem(id: 0, name: "Account"), MenuItem(id: 1, name: "Settings")
        ]
        
        let productsItems = [ MenuItem(id: 0, name: "Add Product"),
                              MenuItem(id: 1, name: "Modify Product"),
                              MenuItem(id: 2, name: "See All Products"),
        ]
        
        let orderMenuItems = [ MenuItem(id: 0, name: "Espresso AV"),
                               MenuItem(id: 1, name: "Espresso EP"),
                               MenuItem(id: 2, name: "Pour Over"),
                               MenuItem(id: 3, name: "Steam")
        ]
        
        let brandItems = [ MenuItem(id: 0, name: "Add Brand"),
                           MenuItem(id: 1, name: "See All Brand"),
        ]
        
        let categoryItems = [ MenuItem(id: 0, name: "Add Category"),
                              MenuItem(id: 1, name: "See All Categories"),
        ]
        
        let supplierItems = [ MenuItem(id: 0, name: "Add Supplier"),
                              MenuItem(id: 1, name: "See All Suppliers"),
        ]
        
        let topMenuItems = [ MenuItem(id: 0, name: "User", subMenuItems: userAccountItems),
                             MenuItem(id: 1, name: "Products", subMenuItems: productsItems),
                             MenuItem(id: 2, name: "Orders", subMenuItems: orderMenuItems),
                             MenuItem(id: 3, name: "Brands", subMenuItems: brandItems),
                             MenuItem(id: 4, name: "Categories", subMenuItems: categoryItems),
                             MenuItem(id: 5, name: "Suppliers", subMenuItems: supplierItems)
        ]
        return topMenuItems
    }()
    
    public class func subMenuItems(for id: MenuItem.ID) -> [MenuItem]? {
        guard let menuItem = MenuViewModel.mainMenuItems.first(where: { $0.id == id }) else {
            return nil
        }
        
        return menuItem.subMenuItems
    }
    
    public class func menuItem(for categoryID: MenuItem.ID, itemID: MenuItem.ID) -> MenuItem? {
        
        guard let subMenuItems = subMenuItems(for: categoryID) else {
            return nil
        }
        
        guard let menuItem = subMenuItems.first(where: { $0.id == itemID }) else {
            return nil
        }
        
        return menuItem
    }
    
    func getSaveInitialData() async throws  {
        let coreProducts = CoreProducts()
        let _ = try await coreProducts.getSaveInitialData(saveInDB: true)
    }
    
}

struct MenuItem: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
    //var image: String
    var subMenuItems: [MenuItem]?
}
