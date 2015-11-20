//
//  SearchViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 21.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    var viewControllerIdentifiers = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeInContainer(sender: UIButton) {
        let newController = storyboard!.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.tag] as! String)
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
