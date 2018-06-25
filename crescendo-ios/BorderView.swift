//
//  RoundButton.swift
//  Juergapp
//
//  Created by Franco Rivera Rivas on 4/24/18.
//  Copyright © 2018 Franco Rivera Rivas. All rights reserved.
//
import UIKit

@IBDesignable class BorderView : UIButton {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
