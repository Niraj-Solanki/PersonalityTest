//
//  QuestionViewControllerTest.swift
//  SparkTests
//
//  Created by Neeraj Solanki on 01/09/21.
//

import XCTest
@testable import Spark

class QuestionViewControllerTest: XCTestCase {

    var questionViewController: QuestionsViewController!
    var mockNetworkManager: NetworkManagerProtocol!
    var viewModel: QuestionsViewModel!
    override func setUp() {
        
        mockNetworkManager = MockNetworkManager()
        viewModel = QuestionsViewModel(networkManager: mockNetworkManager, MockAPIRequest.question(category: "hard_fact"), "hard_fact")
        questionViewController = QuestionsViewController(viewModel)
        questionViewController.loadViewIfNeeded()
        let expectation = self.expectation(description: "API Response")
        questionViewController.viewModel.observable = { (status) in
            
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
        XCTAssert(questionViewController.customNavigationBar.title == viewModel.title, "Controller Title Mismatch")
    }
    
    func testViewModel() {
        XCTAssert(questionViewController.viewModel.noOfSection == 6, "Section No Mismatch")
        XCTAssert(questionViewController.viewModel.noOfRowInSection(section: 0) == 3, "Row Count No Mismatch")
        
        let cellType = questionViewController.viewModel.cellType(indexPath: IndexPath(row: 1, section: 0))
        switch cellType {
        case .optionCell(let optionModel):
            XCTAssert(optionModel.option == "female", "Value Mismatch")
        default:
            print("Wrong cell")
        }
        
    }
    
    func testViewModelWithParitialData() {
           
       }
        
}
