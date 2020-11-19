//
//  DesignableView.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/17/20.
//

import UIKit


class DesignableView : UIView {

    var borderWidth: CGFloat = 2.0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }

    //    self.layer.borderWidth = borderWidth
    //    let cornerRadiusValue = frame.height / 2

    var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    var borderColor: CGColor = UIColor.clear.cgColor {
        didSet{
            layer.borderColor = borderColor
        }
    }


    var shadowColor: UIColor = UIColor.clear {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }

    var shadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }

    var shadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }

    var shadowOffsetY: CGFloat = 0 {
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }

    override var frame: CGRect {
         didSet{
            layer.frame = frame
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
