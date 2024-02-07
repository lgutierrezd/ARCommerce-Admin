//
//  CoreBrand.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 6/2/24.
//

import Foundation
class CoreBrand {
    func getBrands() async throws -> [Brand] {
        do {
            let apiBrands = APIBrands()
            let brands = try await apiBrands.getBrands()
            return brands
        } catch {
            throw error
        }
    }
    
    func addBrand(brand: Brand) async throws -> Brand {
        do {
            let apiBrands = APIBrands()
            let brand = try await apiBrands.addBrand(brand: brand)
            return brand
        } catch {
            throw error
        }
    }
    
    func updateBrand(brand: Brand) async throws -> Brand {
        do {
            let apiBrands = APIBrands()
            return try await apiBrands.updateBrand(brand: brand)
        } catch {
            throw error
        }
    }
    
    func deleteBrand(brand: Brand) async throws -> Bool {
        do {
            let apiBrands = APIBrands()
            return try await apiBrands.deleteBrand(brand: brand)
            
        } catch {
            throw error
        }
    }

}
