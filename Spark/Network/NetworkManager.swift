//
//  NetworkManager.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

protocol NetworkManagerProtocol {
    func request<T:Codable>(_ request: RequestProtocol,success:@escaping((T)->()),failure:@escaping((Error)->()))
}

class NetworkManager : NetworkManagerProtocol {
    
    /// Generic Request Method
    /// - Parameters:
    ///   - request: Should be confirmed with RequestProtocol
    ///   - success: It will return T, AnyModel.Type
    ///   - failure: It will return Error in case of any failure.
    
    func request<T:Codable>(_ request: RequestProtocol,success:@escaping((T)->()),failure:@escaping((Error)->())) {
        DataManager.shared.fetchData(request: request) { error, snapshot in
            if let error = error {
                failure(error)
            }
            else if snapshot.exists() {
                do {
                    if let data = try? JSONSerialization.data(withJSONObject: snapshot.value ?? "", options: []) {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(T.self, from: data)
                        success(result)
                    }
                } catch  {
                    print("Parsing Failed")
                }
            }
            else {
                
            }
        }
    }
}
