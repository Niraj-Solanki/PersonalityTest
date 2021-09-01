//
//  NSNavigationBar.swift
//  Spark
//
//  Created by Neeraj Solanki on 29/08/21.
//

import UIKit

protocol NSNavigationBarDelegate : AnyObject {
    func leftButtonAction()
    func rightButtonAction()
}

extension NSNavigationBarDelegate{
    func rightButtonAction(){}
}

@IBDesignable class NSNavigationBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- Life Cycle
       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
       private func commonInit() {
           Bundle.init(for: NSNavigationBar.self).loadNibNamed("NSNavigationBar", owner: self, options: nil)
           contentView.fixInView(self)
           clipsToBounds = true
        }
    
    
    //MARK:- Properties
    weak var delegate: NSNavigationBarDelegate?
    
    //MARK:- IBInspectable
    @IBInspectable var title: String = "" {
        didSet{
            titleLabel.text = title
        }
    }
    
    @IBInspectable var leftIcon: UIImage? = nil {
        didSet{
            leftButton.setImage(leftIcon, for: .normal)
        }
    }
    
    @IBInspectable var hideLeftIcon: Bool = true {
        didSet{
            leftButton.isHidden = hideLeftIcon
        }
    }
    
    @IBInspectable var rightIcon: UIImage? = nil {
        didSet{
            leftButton.setImage(leftIcon, for: .normal)
        }
    }
    
    @IBInspectable var hideRightIcon: Bool = true {
        didSet{
            rightButton.isHidden = hideRightIcon
        }
    }
    
    //MARK:- Action Methods
    @IBAction func leftButtonAction(_ sender: UIButton) {
        delegate?.leftButtonAction()
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        delegate?.rightButtonAction()
    }
}

//MARK:- UIVIew Extension
extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
