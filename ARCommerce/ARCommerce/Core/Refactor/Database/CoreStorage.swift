//
//  ModelContainer.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 29/12/23.
//

import SwiftData

final class CoreStorage {
    private lazy var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            //Category.self,
//            Brand.self,
//            Supplier.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, allowsSave: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    func getSharedModelContainer() -> ModelContainer {
        return sharedModelContainer
    }
    
    deinit {
        print("CoreStorage deleted")
    }
}



