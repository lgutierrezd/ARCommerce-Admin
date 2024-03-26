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
    
    func testInsert20Products() throws {
        if app.buttons["Iniciar sesión"].exists {
            app.buttons["Iniciar sesión"].tap()
            sleep(2)
        }
        let collectionViewsQuery = app.collectionViews
        
        if app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Add Product"]/*[[".cells",".buttons[\"Add Product\"].staticTexts[\"Add Product\"]",".staticTexts[\"Add Product\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.exists {
            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Product"]/*[[".cells",".buttons[\"Add Product\"].staticTexts[\"Add Product\"]",".staticTexts[\"Add Product\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        if app.navigationBars["Add Product"].buttons["Back"].exists{
            app.navigationBars["Add Product"].buttons["Back"].tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Product"]/*[[".cells",".buttons[\"Add Product\"].staticTexts[\"Add Product\"]",".staticTexts[\"Add Product\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
        
        for i in 0..<7 {
            let nameTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Name"]/*[[".cells.textFields[\"Name\"]",".textFields[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
            nameTextField.doubleTap()
            nameTextField.typeText("Prueba \(i)")
            
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Brands"]/*[[".cells.buttons[\"Brands\"]",".buttons[\"Brands\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Apple"]/*[[".cells.buttons[\"Apple\"]",".buttons[\"Apple\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            let addProductButton = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Add Product"]
            addProductButton.tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Categories"]/*[[".cells.buttons[\"Categories\"]",".buttons[\"Categories\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//            collectionViewsQuery.element.swipeUp()
//            collectionViewsQuery.element.swipeUp()
            collectionViewsQuery.buttons["Apple"].tap()
            addProductButton.tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Suppliers"]/*[[".cells.buttons[\"Suppliers\"]",".buttons[\"Suppliers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["iCon"]/*[[".cells.buttons[\"iCon\"]",".buttons[\"iCon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            addProductButton.tap()
            
            collectionViewsQuery.children(matching: .cell).element(boundBy: 6).buttons["ADD"].tap()
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["size"]/*[[".cells",".segmentedControls.buttons[\"size\"]",".buttons[\"size\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
                        
            let textFieldSize = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Size"]/*[[".cells.textFields[\"Size\"]",".textFields[\"Size\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            

            textFieldSize.doubleTap()
            textFieldSize.typeText("L")
            
            let descriptionTextField = collectionViewsQuery.textFields["Description"]
            descriptionTextField.doubleTap()
            descriptionTextField.typeText("Test Description")
            
            let priceTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Price"]/*[[".cells.textFields[\"Price\"]",".textFields[\"Price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            priceTextField.doubleTap()
            priceTextField.typeText("12345")
            
            
            let costPriceTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Cost Price"]/*[[".cells.textFields[\"Cost Price\"]",".textFields[\"Cost Price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            costPriceTextField.doubleTap()
            costPriceTextField.typeText("12345")
            
            collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Set up Stocks"]/*[[".cells.buttons[\"Set up Stocks\"]",".buttons[\"Set up Stocks\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            sleep(1)
            let addButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["ADD"]/*[[".cells.buttons[\"ADD\"]",".buttons[\"ADD\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            addButton.tap()
            //collectionViewsQuery.buttons["ADD"].tap()
            sleep(1)
            let quantityTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Quantity"]/*[[".cells.textFields[\"Quantity\"]",".textFields[\"Quantity\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            quantityTextField.doubleTap()
            quantityTextField.typeText("13")
            
            addProductButton.tap()
            collectionViewsQuery.children(matching: .cell).element(boundBy: 15).buttons["ADD"].tap()
 
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, August 08, 2012, 3:55 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 30, 2018, 1:14 PM, Photo, August 08, 2012, 3:55 PM, Photo, August 08, 2012, 3:29 PM, Photo, August 08, 2012, 12:52 PM, Photo, October 09, 2009, 3:09 PM, Photo, March 12, 2011, 6:17 PM\"].images[\"Photo, August 08, 2012, 3:55 PM\"]",".images[\"Photo, August 08, 2012, 3:55 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
            collectionViewsQuery.children(matching: .cell).element(boundBy: 15).buttons["ADD"].tap()
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.images["Photo, March 30, 2018, 1:14 PM"]/*[[".otherElements[\"Photos\"].scrollViews.otherElements",".otherElements[\"Photo, March 30, 2018, 1:14 PM, Photo, August 08, 2012, 3:55 PM, Photo, August 08, 2012, 3:29 PM, Photo, August 08, 2012, 12:52 PM, Photo, October 09, 2009, 3:09 PM, Photo, March 12, 2011, 6:17 PM\"].images[\"Photo, March 30, 2018, 1:14 PM\"]",".images[\"Photo, March 30, 2018, 1:14 PM\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
                        
            
            
            
            
            app.navigationBars["Add Product"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            sleep(10)
        }
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
