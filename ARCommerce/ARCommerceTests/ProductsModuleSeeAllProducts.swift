//
//  ProductsModuleSeeAllProducts.swift
//  ARCommerceTests
//
//  Created by Luis Gutierrez on 13/1/24.
//

import XCTest
@testable import ARCommerce

final class ProductsModuleSeeAllProducts: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeeAllProducts() async throws {
        let coreProducts = CoreProducts()
        let products = try await coreProducts.getAllProducts(page: 1)
        XCTAssertTrue(products.count > 0)
    }
    
    func testGetProductcConfiguration() async throws {
        let coreProducts = CoreProducts()
        let configs = try await coreProducts.getProductcConfiguration(productId: "65a6e5f60f7f978c9afd0e59")
        XCTAssertTrue(configs.count > 1)
    }

    func testPerformanceExample() async throws {
        // This is an example of a performance test case.
        let coreProducts = CoreProducts()
        let products = try await coreProducts.getAllProducts(page: 1)
        
        self.measure {
            XCTAssertTrue(products.count > 0)
            // Put the code you want to measure the time of here.
        }
    }

}
