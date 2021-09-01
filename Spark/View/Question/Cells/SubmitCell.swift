//
//  SubmitCell.swift
//  Spark
//
//  Created by Neeraj Solanki on 01/09/21.
//

import UIKit

protocol SubmitDelegate : AnyObject {
    func submitAction(section: Int)
}

class SubmitCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var submitButton: UIButton! {
        didSet{
            submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
            submitButton.clipsToBounds = true
        }
    }
    
    //MARK: - Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    weak var delegate: SubmitDelegate?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private var section: Int?
    private var title: String = "SUBMIT" {
        didSet {
            submitButton.setTitle(title, for: .normal)
        }
    }
    
    private var isEnabled: Bool = true {
        didSet {
            submitButton.isEnabled = isEnabled
            submitButton.backgroundColor = (isEnabled) ? UIColor(named: "NG800") : UIColor(named: "NG500")
            submitButton.setTitleColor((isEnabled) ? UIColor(named: "NG500") : UIColor(named: "NG800"), for: .normal)
        }
    }
    
    func configureCell(model: SubmitCellModel) {
        self.section = model.section
        self.title = model.title
        self.isEnabled = model.isEnabled
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        if let section = section {
            delegate?.submitAction(section: section)
        }
    }
}
