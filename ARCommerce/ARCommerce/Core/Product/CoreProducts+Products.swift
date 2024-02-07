//
//  Core+Products.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 27/12/23.
//

import Foundation
import SwiftData

extension CoreProducts {
    func addProduct(name: String, brand: Brand, category: ARCommerce.Category, suppliers: Set<Supplier>) async throws -> Product {
        do {
            let apiProducts = APIProducts()
            return try await apiProducts.addProduct(name: name, brand: brand, category: category, suppliers: suppliers)
        } catch {
            throw error
        }
    }
    
    @MainActor func getInitialData() throws -> ([Brand]?, [Category]?, [Supplier]?)? {
        let fetchedBrands: [Brand]? = try? database.fetchRecord(from: Brand.self)
        let fetchedCats: [Category]? = try? database.fetchRecord(from: Category.self)
        let fetchedSuppliers: [Supplier]? = try? database.fetchRecord(from: Supplier.self)
       
        return (fetchedBrands, fetchedCats, fetchedSuppliers)
    }
    
    @MainActor fileprivate func saveInitialLoadDB(_ brands: [Brand], _ categories: [Category], _ suppliers: [Supplier]) throws -> ([Brand]?, [Category]?, [Supplier]?)? {
        do {
            try brands.forEach{ brand in
                try database.insertRecord(brand)
            }
            try categories.forEach{ category in
                try database.insertRecord(category)
            }
            try suppliers.forEach{ sup in
                try database.insertRecord(sup)
            }
            
            let fetchedBrands = try database.fetchRecord(from: Brand.self)
            let fetchedCats = try database.fetchRecord(from: Category.self)
            let fetchedSuppliers = try database.fetchRecord(from: Supplier.self)
            
            return (fetchedBrands, fetchedCats, fetchedSuppliers)
        } catch {
            throw error
        }
    }
        
    
    ///This method is called at the beggining of the app or for refresh cached data
    ///loading the necesary data to use the app and
    ///
    ///returning brands, categories and supplier
    func getSaveInitialData(saveInDB: Bool) async throws -> ([Brand]?, [ARCommerce.Category]?, [Supplier]?)? {
        do {
            let brands = try await getBrands()
            let categories = try await getCategories(page: 1, limit: 100)
            let suppliers = try await getSuppliers()
            
            if saveInDB {
                return try await saveInitialLoadDB(brands, categories, suppliers)
            } else {
                return (brands, categories, suppliers)
            }
        } catch {
            throw error
        }
    }
    
    func getCategories(page: Int, limit: Int) async throws -> [ARCommerce.Category] {
        do {
            let apiCategories = APICategories()
            return try await apiCategories.getCategories(page: page, limit: limit)
        } catch {
            throw error
        }
    }
    
    func getBrands() async throws -> [Brand] {
        do {
            let apiBrands = APIBrands()
            let brands = try await apiBrands.getBrands()
            return brands
        } catch {
            throw error
        }
    }
    
    func getSuppliers() async throws -> [Supplier] {
        do {
            let apiSuppliers = APISuppliers()
            let suppliers = try await apiSuppliers.getSuppliers()
            return suppliers
        } catch {
            throw error
        }
    }
    
    func updateProduct(id: String, name: String, brand: Brand, category: ARCommerce.Category, suppliers: Set<Supplier>) async throws -> Product {
        do {
            let apiProducts = APIProducts()
            return try await apiProducts.updateProduct(id: id, name: name, brand: brand, category: category, suppliers: suppliers)
        } catch {
            throw error
        }
    }
    
}
