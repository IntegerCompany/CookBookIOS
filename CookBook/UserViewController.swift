//
//  UserViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 15.09.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    let viewControllerIdentifiers = ["UserRecipesViewController", "MenuTableViewController","FolowersTableViewController","FolowersTableViewController","FolowersTableViewController"]  // storyboard identifiers for the child view controllers
    
    var back : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.back = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: self, action: Selector("backFromGrid:"))
        self.initNavigationButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentDidChangeValue(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let newController = storyboard!.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[index])
        
        switch index {
        case 0:
            (newController as! UserRecipesViewController).delegate = self
            break
        default : break
        }
        
        self.changeViewControllerInContainer(newController)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "initContainerSegue" {
            let vc = segue.destinationViewController as! UserRecipesViewController
            vc.delegate = self
        }
    }
    
    func changeViewControllerInContainer(newController : UIViewController){
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
    
    func initNavigationButtons(){
        let searchFriend = UIButton(frame: CGRectMake(0,0,30, 30))
        searchFriend.setImage(UIImage(named: "addUser"), forState: .Normal)
        
        let searchButton = UIButton(frame: CGRectMake(40,0,30, 30))
        searchButton.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        searchButton.addTarget(self, action: Selector("SearchForUsers:"), forControlEvents: UIControlEvents.TouchUpInside)

        let rightView = UIView(frame:  CGRectMake(0, 0, 70, 30))
        rightView.backgroundColor = UIColor.clearColor()
        
        rightView.addSubview(searchFriend)
        rightView.addSubview(searchButton)
        
        let leftNavBarButton = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        
        self.title = "Max Vitruk"
        
    }
    
    func SearchForUsers(sender : UIButton){
        self.performSegueWithIdentifier("SearchUsersScreen", sender: self)
    }
}

extension UserViewController : UserRecipesDelegate {
    
    func didChooseRecipe(sender: Int) {
        self.navigationItem.leftBarButtonItem = back

        print("Selected recipe : \(sender)")
        let vc = storyboard!.instantiateViewControllerWithIdentifier("RecipeGridViewController") as! RecipeGridViewController
        self.changeViewControllerInContainer(vc)
    }
    
    func backFromGrid(sender : UIBarButtonItem){
        let vc = storyboard!.instantiateViewControllerWithIdentifier("UserRecipesViewController") as! UserRecipesViewController
        vc.delegate = self
        self.changeViewControllerInContainer(vc)
        if back == self.navigationItem.leftBarButtonItem {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
}
