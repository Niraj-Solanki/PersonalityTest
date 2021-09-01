//
//  Destination.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

enum Destination {
    case categories
    case questions(category: Category)
    
    func controller() -> UIViewController {
        switch self {
        case .categories:
            return getCategoryController()
        case .questions(let category):
            return getQuestionsController(category: category)
        }
    }
}

//MARK:- Destination + CategoryViewController
extension Destination {
    func getCategoryController() -> CategoryViewController {
        let viewModel = CategoryViewModel(APIRequest.category)
        let categoryVC = CategoryViewController(viewModel)
        return categoryVC
    }
}

//MARK:- Destination + QuestionsViewController
extension Destination {
    func getQuestionsController(category: Category) -> QuestionsViewController {
        let viewModel = QuestionsViewModel(APIRequest.question(category: category), category)
        let questionsVC = QuestionsViewController(viewModel)
        return questionsVC
    }
}
