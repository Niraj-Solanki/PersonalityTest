//
//  CategoryTableCell.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

class CategoryTableCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var bgView: UIView!{
        didSet {
            bgView.layer.cornerRadius = bgView.frame.size.height / 4
            bgView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- COnfiguration Method
    func configureCell(category: Category) {
        titleLabel.text = category.capitalized.replacingOccurrences(of: "_", with: " ")
    }
}
