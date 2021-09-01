//
//  CategoryViewController.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

class CategoryViewController: UIViewController, Loader {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    private var viewModel: CategoryViewModelProtocol
    
    //MARK:- LifeCycle
    init(_ viewModel: CategoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: CategoryViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeProperties()
    }
    
    //MARK:- Setup
    /// Initialize Properties
    private func initializeProperties() {
        self.tableView.register(CategoryTableCell.nib, forCellReuseIdentifier: CategoryTableCell.identifier)
        self.bindingWork()
        self.viewModel.loadData()
    }
    
    /// Used to Update UI
    private func bindingWork() {
        viewModel.observable = { [weak self] (observerType) in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                switch observerType {
                case .dataLoading:
                    weakSelf.showLoading(show: true)
                case .dataLoaded:
                    weakSelf.showLoading(show: false)
                    weakSelf.tableView.reloadData()
                case .error(let error):
                    weakSelf.showLoading(show: false)
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
    
}

//MARK:- UITableViewDelegate & DataSource
extension CategoryViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableCell.identifier, for: indexPath) as! CategoryTableCell
        cell.configureCell(category: viewModel.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showCategoryQuestions(of: viewModel.categories[indexPath.row])
    }
}

//MARK:- UIViewController Extension: Loadable
extension UIViewController {
    static var className:String? {
        return NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last
    }
}


