//
//  CategoryViewControllerUItest.swift
//  SparkUITests
//
//  Created by Neeraj Solanki on 01/09/21.
//


import XCTest

class CategoryViewControllerUItest: XCTestCase {
    var app:XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLifestyleCategoryCellTaps() {
        app.cells.staticTexts["Lifestyle"].tap()
        app.cells.staticTexts["yes"].firstMatch.tap()
        app.cells.staticTexts["SUBMIT"].tap()
        
        app.cells.staticTexts["maybe"].firstMatch.tap()
        app.cells.staticTexts["SUBMIT"].tap()
    }
}
