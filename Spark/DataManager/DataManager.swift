//
//  DataManager.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit
import FirebaseDatabase

class DataManager {
    static var shared = DataManager()
    let ref: DatabaseReference
    
    private init() {
        ref = Database.database().reference()
    }
    
    /// Fetch Data From Firebase Database
    /// - Parameters:
    ///   - request: Request Protocol
    ///   - completion: It return optional Error & DataSnapshot
    
    func fetchData(request: RequestProtocol,completion:@escaping((Error?,DataSnapshot)->())) {
        ref.child(request.path).getData { (error, snapshot) in
            completion(error,snapshot)
        }
    }
}
