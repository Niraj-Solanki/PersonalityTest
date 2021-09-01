//
//  OptionTableCell.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

class OptionTableCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var selectionIconView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    //MARK: - Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
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
    
    //MARK: - Configuration Method
    ///  Configure Cell is responsible for Upadte UI.
    /// - Parameters:
    ///   - option: Option as String Value
    ///   - isSelected: Update Selection based on this boolean
    
    func configureCell(model: OptionCellModel) {
        optionLabel.text = model.option
        if model.isSelected {
            selectionIconView.image = UIImage(named: "selected")
        }
        else {
            selectionIconView.image = UIImage(named: "unselected")
        }
    }
    
}
