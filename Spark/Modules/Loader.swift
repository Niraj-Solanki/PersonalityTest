//
//  Loader.swift
//  Spark
//
//  Created by Neeraj Solanki on 01/09/21.
//


import UIKit

protocol Loader {
    func showLoading(show: Bool)
}

extension Loader where Self: UIViewController {

    func showLoading(show: Bool) {
        if show {
            showLoading()
        } else {
            hideLoading()
        }
    }

    private func showLoading() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view.center
        activityView.color = UIColor(named: "NG900")
        view.addSubview(activityView)
        activityView.startAnimating()
    }

    private func hideLoading() {
        guard let firstView = self.view.subviews.filter({ type(of: $0) == UIActivityIndicatorView.self }).first,
            let progress = firstView as? UIActivityIndicatorView else { return }
        progress.stopAnimating()
        progress.removeFromSuperview()
    }
}
