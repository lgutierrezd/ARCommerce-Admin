//
//  Database.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/1/24.
//

import SwiftData

class DatabaseFacade {
    fileprivate let sharedModelContainer: ModelContainer
    
    init() {
        let coreStorage = CoreStorage()
        self.sharedModelContainer = coreStorage.getSharedModelContainer()
    }
    
    @MainActor
    func insertRecord<T: PersistentModel>(_ record: T) throws {
        do {
            let context = sharedModelContainer.mainContext
            context.insert(record)
            try context.save()
        } catch {
            throw error
        }
    }
    
    func updateRecord<T: PersistentModel>(_ record: T) throws {
        print("update")
    }
    
    @MainActor
    func deleteRecord<T: PersistentModel>(_ record: T) throws {
        let context = sharedModelContainer.mainContext
        context.delete(record)
    }
    
    @MainActor
    func fetchRecord<T: PersistentModel>(from type: T.Type) throws -> [T]? {
        let context = sharedModelContainer.mainContext
        defer {
            
        }
        return try context.fetch(FetchDescriptor<T>())
    }
    
    deinit {
        print("Database Facade deleted")
    }
}
