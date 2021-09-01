//
//  QuestionsViewController.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

class QuestionsViewController: UIViewController, Loader {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationBar: NSNavigationBar!
    
    //MARK:- Properties
    private var viewModel: QuestionsViewModelProtocol
    
    //MARK:- Life Cycle
    init(_ viewModel: QuestionsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: QuestionsViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeProperties()
    }
    
    //MARK:- Setup
    private func initializeProperties() {
        self.customNavigationBar.delegate = self
        
        self.tableView.register(OptionTableCell.nib, forCellReuseIdentifier: OptionTableCell.identifier)
        self.tableView.register(SubmitCell.nib, forCellReuseIdentifier: SubmitCell.identifier)
        self.tableView.register(ConditionCell.nib, forCellReuseIdentifier: ConditionCell.identifier)
        self.tableView.register(QuestionHeaderCell.nib, forHeaderFooterViewReuseIdentifier: QuestionHeaderCell.identifier)

        self.customNavigationBar.title = viewModel.title
        
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
extension QuestionsViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.noOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.noOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellType(indexPath: indexPath) {
        case .optionCell(let optionModel):
           return getOptionCell(indexPath,optionModel)
        case .submitCell(let submitModel):
            return getSubmitCell(indexPath,submitModel)
        case .conditionalCell(let ifPositiveModel):
            return conditioalCell(indexPath, ifPositiveModel)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.performSelection(indexPath: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: QuestionHeaderCell.identifier) as! QuestionHeaderCell
        headerCell.configureHeader(title: viewModel.headerTitle(in: section))
        return headerCell
    }
    
}

//MARK:- Get Cells
extension QuestionsViewController {
    private func getOptionCell(_ indexPath: IndexPath,_  optionModel: OptionCellModel) -> OptionTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableCell.identifier, for: indexPath) as! OptionTableCell
        cell.configureCell(model: optionModel)
        return cell
    }
    
    private func getSubmitCell(_ indexPath: IndexPath,_ submitCellModel: SubmitCellModel) -> SubmitCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubmitCell.identifier, for: indexPath) as! SubmitCell
        cell.delegate = self
        cell.configureCell(model: submitCellModel)
        return cell
    }
    
    private func conditioalCell(_ indexPath: IndexPath,_ ifPositiveModel: IfPositive) -> ConditionCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConditionCell.identifier, for: indexPath) as! ConditionCell
        cell.configureCell(ifPositiveModel)
        return cell
    }
}

//MARK:- SubmitDelegate
extension QuestionsViewController : SubmitDelegate {
    func submitAction(section: Int) {
        viewModel.submitAnswer(of: section)
    }
}

//MARK:- NSNavigationBarDelegate
extension QuestionsViewController : NSNavigationBarDelegate {
    func leftButtonAction() {
        try? AppNavigation().pop(true)
    }
}
