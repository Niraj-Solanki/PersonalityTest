//
//  MockAPIRequest.swift
//  SparkTests
//
//  Created by Neeraj Solanki on 01/09/21.
//


import UIKit

enum MockAPIRequest {
    case category
    case question(category: String)
}

extension MockAPIRequest: RequestProtocol {
    var baseURL: URL {
        return URL(string: "https://run.mocky.io/v3")!
    }
    
    var path: String {
        switch  self {
        case .category:
            return "/e3d5d8bd-3c1c-4893-bf2f-b4aa9464ff92"
        case .question(_ ):
            return "422700c2-11b9-419d-9e9d-9652acd23cd9"
        }
    }
    
    
    var version: String{
        return "/v3"
    }
    
    var httpMethod: HTTPMethod{
        switch self {
        case .category:
            return .get
        case .question(_ ):
            return .get
        }
    }
}

