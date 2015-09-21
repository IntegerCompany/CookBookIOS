//
//  UserViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 15.09.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    let viewControllerIdentifiers = ["UserRecipesViewController", "UserMenuViewController"]  // storyboard identifiers for the child view controllers
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didChangeValue(sender: UIButton) {
        let newController = storyboard!.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.tag])
        let oldController = childViewControllers.last
        
        oldController!.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = oldController!.view.frame
        
        transitionFromViewController(oldController!, toViewController: newController, duration: 0.25, options: .TransitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController!.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        })
    }
}
