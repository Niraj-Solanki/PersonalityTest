//
//  EndPoint.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

/// Request Protocol
protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var query:(orderBy:String,value:String)? { get }
}
