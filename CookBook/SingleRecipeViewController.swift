//
//  VideoController.swift
//  CookBook
//
//  Created by Max Vitruk on 22.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit
import AVFoundation

class SingleRecipeViewController : UIViewController , UIScrollViewDelegate {
    
    @IBOutlet weak var textRextWithBorder: UIView!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var controlContainer: UIView!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    var controlContainerOriginalOffset : CGFloat?
    var recipe : Recipe?
    var offsetLable = "Overview"
    var mainColor : UIColor?
    
    var _SRVCcontainerHeight : CGFloat?
    let hardCodeContentInOverview : CGFloat  = 278
    
    let viewControllerIdentifiers = ["SROverviewController", "SRIngredientController" ,"SRStepsController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        self.mainColor = UIColor(hex: (self.recipe?.img.hex)!)
        self.textRextWithBorder.layer.borderWidth = 1.0
        self.textRextWithBorder.layer.borderColor = UIColor.darkGrayColor().CGColor
        
        self.segmentedControll.tintColor = UIColor.darkGrayColor()
        
        self.recipeName.text = recipe?.caption
        self.recipeName.textColor = mainColor
        
        
        if let img = recipe?.img {
            let boundingRect =  CGRect(x: 0, y: 0, width: (self.view.bounds.width - 20), height: CGFloat(MAXFLOAT))
            let rect  = AVMakeRectWithAspectRatioInsideRect(img.rect, boundingRect)
            _SRVCcontainerHeight = rect.height
            self.containerHeight.constant = self.hardCodeContentInOverview + _SRVCcontainerHeight!
        }
        
        self.tabBarController?.tabBar.hidden = true

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.hidden = true
        self.controlContainerOriginalOffset = self.controlContainer.frame.origin.y
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openOverviewCotroller" {
            let vc = segue.destinationViewController as! SROverviewController
            vc.recipe = self.recipe
        }
    }
    
    @IBAction func didChangeValue(sender: UISegmentedControl) {
        var newController : UIViewController?
        let oldController = childViewControllers.last!
        self.scrollToSegmentControl()

        switch sender.selectedSegmentIndex {
        case 0:
            //TODO REBUILD THIS CODE
            let vc = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]) as! SROverviewController
            vc.recipe = self.recipe
            
            self.containerHeight.constant = self.hardCodeContentInOverview + _SRVCcontainerHeight!
                
            self.offsetLable = "Overview"
            newController = vc
            break
        case 1:
            let vc = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]) as! SRIngredientController
            newController = vc
            vc.recipe = self.recipe
            self.offsetLable = "Ingredients"
            break
        case 2:
            let vc = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]) as! SRStepsController
            newController = vc
            self.offsetLable = "Steps"
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
    
    func scrollToSegmentControl(){
        UIView.animateWithDuration(0.8, animations: { ()->Void in
            self.scrollView.contentOffset.y = self.controlContainerOriginalOffset!
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollViewDidScroll = \(scrollView.contentOffset.y)")
        if controlContainerOriginalOffset < scrollView.contentOffset.y {
            self.title = self.offsetLable

            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go up" , style: UIBarButtonItemStyle.Plain , target: self, action: Selector("scrollToSegmentControl"))
        }else{
            self.title = nil
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
}
