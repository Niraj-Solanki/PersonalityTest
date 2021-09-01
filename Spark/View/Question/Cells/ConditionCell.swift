//
//  ConditionCell.swift
//  Spark
//
//  Created by Neeraj Solanki on 01/09/21.
//

import UIKit

class ConditionCell: UITableViewCell {

    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedValueLabel: UILabel!
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
    
    func configureCell(_ model: IfPositive) {
        titleLabel.text = model.question
        if model.questionType?.type == .numberRange, let range = model.questionType?.range { // Range Selection
            sliderBar.minimumValue = Float(range.from ?? 0)
            sliderBar.maximumValue = Float(range.to ?? 0)
        }
        else{
            sliderBar.isHidden = true
        }
    }

    @IBAction func sliderAction(_ sender: UISlider) {
        selectedValueLabel.text = "\(Int(sender.value))"
    }
    
}
