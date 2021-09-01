//
//  QuestionsViewModel.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

protocol QuestionsViewModelProtocol {
    var observable: ((ObserverType)->Void)? { get set }
    var questions: [Questions] { get }
    var title: String { get }
    var noOfSection: Int { get }
    var networkManager: NetworkManager { get }
    func loadData()
    
    func performSelection(indexPath: IndexPath)
    func submitAnswer(of section: Int)
    func cellType(indexPath: IndexPath) -> QuestionViewCellType
    func noOfRowInSection(section: Int) -> Int
    func headerTitle(in section: Int) -> String
}

enum QuestionViewCellType {
    case optionCell(optionModel: OptionCellModel)
    case conditionalCell(ifPositiveModel: IfPositive)
    case submitCell(submitModel: SubmitCellModel)
}

final class QuestionsViewModel: QuestionsViewModelProtocol {
    var observable: ((ObserverType) -> Void)?
    var networkManager = NetworkManager()
    var requestProtocol: RequestProtocol
    var category: Category
    
    var questions: [Questions] = []{
        didSet{
            observable?(.dataLoaded)
        }
    }
    
    init(_ requestProtocol: RequestProtocol,_ category: Category) {
        self.requestProtocol = requestProtocol
        self.category = category
    }
    
    var title: String {
        return category.capitalized
    }
    
    var noOfSection: Int {
        if questions.count > 0 {
            return questions.count + 1 // Submit All
        }
        
        return 0
    }
    
    func performSelection(indexPath: IndexPath) {
        if indexPath.section < questions.count {
            if indexPath.row < questions[indexPath.section].question_type.options.count {
                var selectedOption = questions[indexPath.section].question_type.options[indexPath.row]
                
                if questions[indexPath.section].question_type.selectedOption == selectedOption {
                    selectedOption = ""
                }
                
                questions[indexPath.section].question_type.selectedOption = selectedOption
                questions[indexPath.section].question_type.isSubmitted = false
            }
        }
    }
    
    func submitAnswer(of section: Int) {
        if section < questions.count {
            questions[section].question_type.isSubmitted = true // Update on Success
        }
        else { // Submit Question
            // Submit API
        }
    }
    
    private func getOptionCellModel(_ indexPath: IndexPath) -> OptionCellModel {
        let option = questions[indexPath.section].question_type.options[indexPath.row]
        var isSelected = false
        if questions[indexPath.section].question_type.selectedOption == option {
            isSelected = true
        }
        
        return OptionCellModel(option: option, isSelected: isSelected)
    }
    
    private func getSubmitCellModel(_ indexPath: IndexPath) -> SubmitCellModel {
        if indexPath.section < questions.count {
            if questions[indexPath.section].question_type.isSubmitted{
                return SubmitCellModel(title: ConstantKeys.SUBMITTED.rawValue, isEnabled: false, section: indexPath.section)
            }
            else{
                return SubmitCellModel(title: ConstantKeys.SUBMIT.rawValue, isEnabled: true, section: indexPath.section)
            }
        }
        else {
            // Submit ALl WOork
            return SubmitCellModel(title: ConstantKeys.SUBMIT_ALL.rawValue, isEnabled: true, section: indexPath.section)
        }
    }
    
    func cellType(indexPath: IndexPath) -> QuestionViewCellType {
        if indexPath.section < questions.count {
            if indexPath.row < questions[indexPath.section].question_type.options.count {
                return .optionCell(optionModel: getOptionCellModel(indexPath))
            }
            else if isConditionCellEligible(indexPath), let ifPositiveModel = questions[indexPath.section].question_type.condition?.ifPositive {
                return .conditionalCell(ifPositiveModel: ifPositiveModel)
            }
            else{
                return .submitCell(submitModel: getSubmitCellModel(indexPath))
            }
        }
        else {
            return .submitCell(submitModel: getSubmitCellModel(indexPath))
        }
    }
    
    private func isConditionCellEligible(_ indexPath: IndexPath) -> Bool {
        if indexPath.row == questions[indexPath.section].question_type.options.count && questions[indexPath.section].question_type.type == .singleChoiceConditional{
            let selectedOption = questions[indexPath.section].question_type.selectedOption
            if let values = questions[indexPath.section].question_type.condition?.predicate?.exactEquals, selectedOption == values.last {
                return true
            }
        }
        return false
    }
    
    func noOfRowInSection(section: Int) -> Int {
        if section < questions.count {
            let selectedOption = questions[section].question_type.selectedOption
            if selectedOption != "" {
                var additionalCellsCount = 1 // Enable Submit Button
                
                if questions[section].question_type.type == .singleChoiceConditional {
                    if let values = questions[section].question_type.condition?.predicate?.exactEquals, selectedOption == values.last {
                        additionalCellsCount = additionalCellsCount + 1
                    }
                }
                return questions[section].question_type.options.count + additionalCellsCount
            }
            else {
                return questions[section].question_type.options.count
            }
            
        } else {
            return 1 // Submit All 
        }
    }
    
    func headerTitle(in section: Int) -> String {
        if section < questions.count {
            return questions[section].question
        } else {
            return ""
        }
    }
    
    func loadData() {
        observable?(.dataLoading)
        
        networkManager.request(requestProtocol) {
            [weak self] (result:[Questions]) in
            guard let weakSelf = self else { return }
            weakSelf.questions = result.filter({ $0.category == weakSelf.category })
        } failure: { [weak self] error in
            self?.observable?(.error(error: error))
        }
    }
    
}
