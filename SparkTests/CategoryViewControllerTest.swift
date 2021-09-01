//
//  CategoryViewControllerTest.swift
//  SparkTests
//
//  Created by Neeraj Solanki on 01/09/21.
//

import XCTest
@testable import Spark
class CategoryViewControllerTest: XCTestCase {

    var categoryViewController: CategoryViewController!
    var mockNetworkManager: NetworkManagerProtocol!
    var viewModel: CategoryViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockNetworkManager = MockNetworkManager()
        viewModel = CategoryViewModel(networkManager: mockNetworkManager, MockAPIRequest.category)
        categoryViewController = CategoryViewController(viewModel)
        categoryViewController.loadViewIfNeeded()
        let expectation = self.expectation(description: "API Response")
        categoryViewController.viewModel.observable = { (status) in
            
            DispatchQueue.main.async {
                switch status {
                case .dataLoading:
                    print("Data Loading")
                case .dataLoaded:
                    print("Data Loaded")
                    expectation.fulfill()
                default:
                    print("Other Cases")
                }
            }
        }
        waitForExpectations(timeout: 5, handler: nil)

    }

    override func tearDown() {
        
    }

    func testControllerTitle() {
        //Controller Title Must Same as Category Name
        XCTAssert(categoryViewController.customNavigationBar.title == "Personality Test", "Controller Title Mismatch")
    }
    
    func testViewModel() {
        XCTAssert(categoryViewController.viewModel.categories == ["hard_fact","lifestyle","introversion","passion"], "Categories Mismatch")
    }
    
    func testViewModelWithParitialData() {
           
       }
        
}
