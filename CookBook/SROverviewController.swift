//
//  SROverviewController.swift
//  CookBook
//
//  Created by Max Vitruk on 23.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit
import AVFoundation

class SROverviewController : UIViewController {
    
    @IBOutlet weak var SRDescription: UILabel!
    @IBOutlet weak var SRComnetsCount: UILabel!
    @IBOutlet weak var SRLikesCount: UILabel!
    
    @IBOutlet weak var SROwnerName: UILabel!
    @IBOutlet weak var SROwnerStatus: UILabel!
    
    @IBOutlet weak var SROwnerImage: RoundedImageView!
    
    @IBOutlet weak var SRImageHeight: NSLayoutConstraint!
    @IBOutlet weak var SRMainRecipeName: RoundedImageView!
    
    @IBOutlet weak var letsCookButton: UIButton!
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = recipe?.image {
            let boundingRect =  CGRect(x: 0, y: 0, width: (self.view.bounds.width - 20), height: CGFloat(MAXFLOAT))
            let rect  = AVMakeRectWithAspectRatioInsideRect(recipe!.img.rect, boundingRect)
            self.SRImageHeight.constant = rect.height
            self.SRMainRecipeName.image = image
        }
        if let description = recipe?.comment {
            self.SRDescription.text = description
        }
        
        if let color = recipe?.img.hex {
            self.letsCookButton.layer.backgroundColor = UIColor(hex: color).CGColor
        }
    }
    @IBAction func letsCookAction(sender: RoundedButton) {
    }
}