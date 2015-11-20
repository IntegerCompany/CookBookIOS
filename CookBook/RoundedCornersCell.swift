//
//  RoundedCornersCell.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersCell: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
        backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
}

@IBDesignable
class RoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}