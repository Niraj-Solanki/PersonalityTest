//
//  CategoryViewModel.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

enum ObserverType {
    case dataLoading
    case dataLoaded
    case error(error: Error)
}

protocol CategoryViewModelProtocol {
    var observable: ((ObserverType)->Void)? { get set }
    var categories: [Category] { get }
    var networkManager: NetworkManager { get }
    
    func showCategoryQuestions(of category: String)
    func loadData()
}

class CategoryViewModel : CategoryViewModelProtocol {
  
    //MARK:- Properties
    internal let networkManager = NetworkManager()
    internal var observable: ((ObserverType) -> Void)?
    internal var categories: [Category] = [] {
        didSet {
            observable?(.dataLoaded)
        }
    }
    var requestProtocol: RequestProtocol
    
    //MARK:- Life Cycle
    init(_ requestProtocol: RequestProtocol) {
        self.requestProtocol = requestProtocol
    }
    
    func loadData()  {
        observable?(.dataLoading)
        
        networkManager.request(requestProtocol) { [weak self] (result: [Category]) in
            self?.categories = result
        } failure: { [weak self] error in
            self?.observable?(.error(error: error))
        }
    }
    
    func showCategoryQuestions(of category: String) {
        try? AppNavigation().push(.questions(category: category), true)
    }
}
