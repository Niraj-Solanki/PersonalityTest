//
//  AppNavigation.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

protocol Navigation {
    func push(_ destination: Destination,_ animation: Bool)
    func present(_ destination: Destination,_ animation: Bool)
    func pop(_ animation: Bool)
    func dismiss(_ animation: Bool)
}

class AppNavigation {
    
    private static var rootController: UINavigationController!{
        didSet{
            rootController.navigationBar.isHidden = true
        }
    }
    
    init(window: UIWindow) {
        
        AppNavigation.rootController = UINavigationController(rootViewController: Destination.categories.getCategoryController())
    
        window.rootViewController = AppNavigation.rootController
        window.makeKeyAndVisible()
    }
    
    init() throws {
        if AppNavigation.rootController == nil {
            throw NavigatorError.noRoot
        }
    }
}

extension AppNavigation : Navigation{
    
    func push(_ destination: Destination, _ animation: Bool = true) {
        AppNavigation.rootController.pushViewController(destination.controller(), animated: animation)
    }
    
    func present(_ destination: Destination, _ animation: Bool = true) {
        AppNavigation.rootController.present(destination.controller(), animated: animation, completion: nil)
    }
    
    func pop(_ animation: Bool) {
        AppNavigation.rootController.popViewController(animated: true)
    }
    
    func dismiss(_ animation: Bool) {
        AppNavigation.rootController.dismiss(animated: animation, completion: nil)
    }
}

enum NavigatorError: Error {
    case noRoot
}
