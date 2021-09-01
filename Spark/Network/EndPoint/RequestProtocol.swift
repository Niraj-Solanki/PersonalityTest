//
//  EndPoint.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit


public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete  = "DELETE"
}

/// Request Protocol
protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var version: String { get }
    var httpBody: Data? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}

extension RequestProtocol{
    var version: String {
        return ""
    }
    
    var httpMethod: HTTPMethod{
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var httpBody: Data? {
        return nil
    }
}



