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
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var controlContainer: UIView!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    var recipe : Recipe?
    
    let viewControllerIdentifiers = ["SROverviewController", "second"]  // storyboard identifiers for the child view controllers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(hex: (self.recipe?.img.hex)!)
        self.textRextWithBorder.layer.borderWidth = 2.0
        self.textRextWithBorder.layer.borderColor = color.CGColor
        
        self.segmentedControll.tintColor = color
        
        self.recipeName.text = recipe?.caption
        self.recipeName.textColor = color
        
//        let boundingRect =  CGRect(x: 0, y: 0, width: (self.view.bounds.width - 20), height: CGFloat(MAXFLOAT))
//        let rect  = AVMakeRectWithAspectRatioInsideRect(recipe!.img.rect, boundingRect)
//        self.imageHeight.constant = rect.height

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func didChangeValue(sender: UISegmentedControl) {
        var newController : UIViewController?
        let oldController = childViewControllers.last!
        
        switch sender.selectedSegmentIndex {
        case 0:
            newController = (storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]))
            break
        case 1:
            newController = UIViewController(nibName: "OverViewNib", bundle: NSBundle.mainBundle())
            break
        case 2:
            newController = UIViewController(nibName: "OverViewNib", bundle: NSBundle.mainBundle())
            break
        default:
            newController = (storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]))
            break
        }
        
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController!)
        newController!.view.frame = oldController.view.frame
        
        transitionFromViewController(oldController, toViewController: newController!, duration: 0.25, options: .TransitionCrossDissolve, animations:{ () -> Void in
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController!.didMoveToParentViewController(self)
        })
    }
}
