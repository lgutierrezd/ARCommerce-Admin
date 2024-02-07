//
//  CoreSuplier.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 5/2/24.
//

import Foundation

class CoreSupplier {
    func getSuppliers() async throws -> [Supplier] {
        do {
            let apiSuppliers = APISuppliers()
            let suppliers = try await apiSuppliers.getSuppliers()
            return suppliers
        } catch {
            throw error
        }
    }
    
    func addSupplier(supplier: Supplier) async throws -> Supplier {
        do {
            let apiSupplier = APISuppliers()
            let supplier = try await apiSupplier.addSuppliers(supplier: supplier)
            return supplier
        } catch {
            throw error
        }
    }
    
    func getSupplier(id: String) async throws -> Supplier {
        do {
            let apiSupplier = APISuppliers()
            return try await apiSupplier.getUpdateDeleteSuppliers(id: id, supplier: nil, method: .get)!
        } catch {
            throw error
        }
        
    }
    
    func updateSupplier(id: String, supplier: Supplier) async throws -> Supplier {
        do {
            let apiSupplier = APISuppliers()
            return try await apiSupplier.getUpdateDeleteSuppliers(id: id, supplier: supplier, method: .patch)!
        } catch {
            throw error
        }
    }
    
    func deleteSupplier(id: String) async throws -> Bool {
        do {
            let apiSupplier = APISuppliers()
            let supplier: Supplier? = try await apiSupplier.getUpdateDeleteSuppliers(id: id, supplier: nil, method: .delete)
            if supplier == nil {
                return true
            }
        } catch {
            throw error
        }
        return false
    }

}
