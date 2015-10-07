//
//  SearchViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 21.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var container: UIView!
    
    var viewControllerIdentifiers = []
    
    var searchButton = UIButton(frame: CGRectMake(320,0,30, 30))
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 350, 30))
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigationButtons()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSearchOptions(sender : UIButton) {
        searchButton.hidden = true
        searchBar.hidden = false
        searchBar.becomeFirstResponder()
    }
    func cancelSearchOptions() {
        searchButton.hidden = false
        searchBar.hidden = true
    }
    
    func initNavigationButtons(){
        searchBar.delegate = self
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.placeholder = "Search"
        searchBar.hidden = true
        searchBar.showsCancelButton = true
        let rightView = UIView(frame:  CGRectMake(0, 0, 360, 30))
        rightView.backgroundColor = UIColor.clearColor()
        
        searchButton.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        searchButton.tag=101
        searchButton.addTarget(self, action: "showSearchOptions:", forControlEvents: UIControlEvents.TouchUpInside)
        
        rightView.addSubview(searchBar)
        rightView.addSubview(searchButton)
        
        let leftNavBarButton = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearchOptions()
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGrayColor()
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
//        let uiButton = searchBar.valueForKey("cancelButton") as! UIButton
//        uiButton.setTitle("Done", forState: UIControlState.Normal)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        print("\nSearching")
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
//        filtered = data.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.tableView.reloadData()
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
