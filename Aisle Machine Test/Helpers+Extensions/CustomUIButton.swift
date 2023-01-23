//
//  CustomUIButton.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 20/01/23.
//

import Foundation
import UIKit

@IBDesignable
class customUIButton : UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 20 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var textColor : UIColor = .darkText {
        didSet {
            self.titleLabel?.textColor = textColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.4 {
        didSet {
            self.layer.masksToBounds = false
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 1, height: 4) {
        didSet {
            self.layer.masksToBounds = false
            self.layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = CGFloat(0.5) {
        didSet {
            self.layer.masksToBounds = false
            self.layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.masksToBounds = false
        }
    }
    @IBInspectable var defaultBackgroundColor : UIColor = UIColor(red: 249/255, green: 203/255, blue: 16/255, alpha: 1.0) {
        didSet {
            self.layer.backgroundColor = defaultBackgroundColor.cgColor
        }
    }
}
