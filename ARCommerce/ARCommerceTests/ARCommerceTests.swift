//
//  ARCommerceTests.swift
//  ARCommerceTests
//
//  Created by Luis Gutierrez on 6/12/23.
//

import XCTest
import Combine
@testable import ARCommerce

final class ARCommerceTests: XCTestCase {

    var subscribers = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let categoryService = CategoryService()
                let expectation = XCTestExpectation(description: "Recibir categorías")

                categoryService.getCategories(page: "1", limit: "20")
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            // Si la solicitud se completa correctamente, cumplimos con la expectativa
                            expectation.fulfill()
                        case .failure(let error):
                            // Si hay un error, fallamos la prueba
                            XCTFail("Error al obtener categorías: \(error)")
                        }
                    }, receiveValue: { categories in
                        // Aquí puedes hacer las aserciones necesarias sobre las categorías recibidas
                        // Por ejemplo, verificar que el número de categorías es el esperado
                        XCTAssertGreaterThan(categories.count, 0, "Se esperan categorías")
                    })
                    .store(in: &subscribers)

                // Esperamos un tiempo razonable para que se complete la solicitud
                wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
