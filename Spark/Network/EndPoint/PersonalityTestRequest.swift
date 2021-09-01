//
//  PersonalityTestEndPoint.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

enum APIRequest {
    case category
    case question(category: String)
}

extension APIRequest: RequestProtocol {
    // Can be used for Server API
    var baseURL: URL {
        switch  self {
        case .category:
            return URL(string: "")!
        case .question(_ ):
            return URL(string: "")!
        }
    }
    
    var path: String {
        switch  self {
        case .category:
            return "categories"
        case .question(_ ):
            return "questions"
        }
    }
    
    var query: (orderBy: String, value: String)? {
        switch  self {
        case .category:
            return nil
        case .question(let category):
            return (orderBy: "category", value: category)
        }
    }
    
}
