//
//  MockNetworkManager.swift
//  SparkTests
//
//  Created by Neeraj Solanki on 01/09/21.
//

import UIKit

class MockNetworkManager: NetworkManagerProtocol {
    func request<T:Codable>(_ request: RequestProtocol, success: @escaping ((T) -> ()), failure: @escaping ((Error) -> ())) {
        
        let session = URLSession.shared
        var sessionRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        sessionRequest.httpMethod = request.httpMethod.rawValue
        sessionRequest.httpBody = request.httpBody
        sessionRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: sessionRequest) { data, response, error in
            
            if error != nil{
                failure(error!)
                return
            }
            else{
                do {
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(T.self, from: data)
                        success(result)
                    }
                } catch {
                    print("JSONSerialization error:", error)
                }
            }
        }.resume()
        
    }
    
    
}
