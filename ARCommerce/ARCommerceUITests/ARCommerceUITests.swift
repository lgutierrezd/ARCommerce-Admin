//
//  ARCommerceUITests.swift
//  ARCommerceUITests
//
//  Created by Luis Gutierrez on 6/12/23.
//

import XCTest

final class ARCommerceUITests: XCTestCase {
    var app: XCUIApplication!
    var buttonLogin: XCUIElement!

    override func setUpWithError() throws {
        app = XCUIApplication()
        buttonLogin = app.buttons["Iniciar sesión"].firstMatch
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        buttonLogin.tap()
        let newViewAppeared = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.navigationBars.firstMatch, handler: nil)
        
        wait(for: [newViewAppeared], timeout: 10)
        XCTAssertTrue(app.navigationBars.firstMatch.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                buttonLogin.tap()
                let newViewAppeared = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.navigationBars.firstMatch, handler: nil)
                wait(for: [newViewAppeared], timeout: 10)
            }
        }
    }
}
