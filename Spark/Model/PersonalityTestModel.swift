//
//  PersonalityTestModel.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

typealias Category = String
typealias Option = String
typealias SelecctionType = String
typealias Question = String

struct PersonalityTestModel : Codable {
    let categories : [Category]?
    let questions : [Questions]?

    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case questions = "questions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        questions = try values.decodeIfPresent([Questions].self, forKey: .questions)
    }
}


struct Questions : Codable {
    let question: Question
    let category: Category
    var question_type: QuestionType

    enum CodingKeys: String, CodingKey {
        case question = "question"
        case category = "category"
        case question_type = "question_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        question = try values.decode(Question.self, forKey: .question)
        category = try values.decode(Category.self, forKey: .category)
        question_type = try values.decode(QuestionType.self, forKey: .question_type)
    }
}

struct QuestionType : Codable {
    let options : [Option]
    let type : SelecctionTypeEnum?
    let condition: Condition?
    var selectedOption: String = ""
    var isSubmitted: Bool = false

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case options = "options"
        case condition = "condition"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        options = try values.decode([Option].self, forKey: .options)
        type = try values.decodeIfPresent(SelecctionTypeEnum.self, forKey: .type)
        condition = try? values.decodeIfPresent(Condition.self, forKey: .condition)
    }
}



// MARK: - Condition
struct Condition: Codable {
    let predicate: Predicate?
    let ifPositive: IfPositive?
    enum CodingKeys: String, CodingKey {
        case predicate
        case ifPositive = "if_positive"
    }
}

// MARK: - IfPositive
struct IfPositive: Codable {
    let question: Question?
    let category: Category?
    let questionType: IfPositiveQuestionType?

    enum CodingKeys: String, CodingKey {
        case question
        case category
        case questionType = "question_type"
    }
}

// MARK: - IfPositiveQuestionType
struct IfPositiveQuestionType: Codable {
    let type: SelecctionTypeEnum?
    let range: Range?
}

// MARK: - Range
struct Range: Codable {
    let from: Int?
    let to: Int?
}

// MARK: - Predicate
struct Predicate: Codable {
    let exactEquals: [String]?
}

enum SelecctionTypeEnum: String, Codable, Equatable {
    case singleChoice = "single_choice"
    case singleChoiceConditional = "single_choice_conditional"
    case numberRange = "number_range"
}
