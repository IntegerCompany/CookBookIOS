//
//  VideoController.swift
//  CookBook
//
//  Created by Max Vitruk on 22.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class SingleRecipeViewController : UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var bgImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.backgroundImage.image = bgImage!
    }
}
