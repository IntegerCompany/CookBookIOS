//
//  SRIngedientsController.swift
//  CookBook
//
//  Created by Max Vitruk on 23.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class SRIngredientController : UIViewController {
    
    @IBOutlet weak var SRIContainer: UIView!
    @IBOutlet weak var SRIStack: UIStackView!
    
    @IBOutlet weak var _SRIRow: UIView!
    
    @IBOutlet weak var _SRIContainerHeight: NSLayoutConstraint!
    
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let v = UIView()
        
//        v.layer.backgroundColor = UIColor.redColor().CGColor
//        for _ in 1...5 {
//            self.SRIStack.addArrangedSubview(v)
//            self._SRIContainerHeight.constant += v.frame.height
//        }
    }
    
}