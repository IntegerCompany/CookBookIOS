//
//  VideoController.swift
//  CookBook
//
//  Created by Max Vitruk on 22.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit
import AVFoundation

class SingleRecipeViewController : UIViewController {
    
    @IBOutlet weak var textRextWithBorder: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var recipeEnergy: UILabel!
    @IBOutlet weak var recipePersons: UILabel!
    @IBOutlet weak var recipeCookTIme: UILabel!
    
    @IBOutlet weak var mainDescription: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerStatus: UILabel!
    @IBOutlet weak var ownerImage: RoundedImageView!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(hex: (self.recipe?.img.hex)!)
        self.textRextWithBorder.layer.borderWidth = 2.0
        self.textRextWithBorder.layer.borderColor = color.CGColor
        
        self.recipeName.text = recipe?.caption
        self.recipeName.textColor = color
        
        self.comments.text = recipe?.comment
        
        let boundingRect =  CGRect(x: 0, y: 0, width: (self.view.bounds.width - 20), height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRectWithAspectRatioInsideRect(recipe!.img.rect, boundingRect)
        self.imageHeight.constant = rect.height

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.backgroundImage.image = self.recipe?.image
    }
}
