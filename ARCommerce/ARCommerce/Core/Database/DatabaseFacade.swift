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
    
    func deleteRecord<T: PersistentModel>(_ record: T) throws {
        print("delete")
    }
    
    @MainActor
    func fetchRecord<T: PersistentModel>(from type: T.Type) throws -> [T]? {
        let context = sharedModelContainer.mainContext
        return try context.fetch(FetchDescriptor<T>())
    }
    
    deinit {
        print("Database Facade deleted")
    }
}

/*protocol DatabaseOperable {
    func insertRecord<T: PersistentModel>(_ record: T) throws
    func updateRecord<T: PersistentModel>(_ record: T)
    func deleteRecord<T: PersistentModel>(_ record: T)
    func fetchRecord<T: PersistentModel>(withID type: T.Type) throws -> [T]?
}

class Database: DatabaseOperable {
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
    
    @MainActor
    func updateRecord<T: PersistentModel>(_ record: T) {
        print("updateRecord")
    }
    
    @MainActor
    func deleteRecord<T: PersistentModel>(_ record: T) {
        print("deleteRecord")
    }
    
    @MainActor
    func fetchRecord<T: PersistentModel>(withID type: T.Type) throws -> [T]? {
        let context = sharedModelContainer.mainContext
        return try context.fetch(FetchDescriptor<T>())
    }
    
    deinit {
        print("Database deleted")
    }
}
*/
