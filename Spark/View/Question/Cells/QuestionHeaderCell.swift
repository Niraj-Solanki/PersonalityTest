//
//  QuestionHeaderCell.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

class QuestionHeaderCell: UITableViewHeaderFooterView {
    
    //MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
   
    //MARK:- Cinfigure Method
    func configureHeader(title: Question) {
        titleLabel.text = title
    }
    
}
