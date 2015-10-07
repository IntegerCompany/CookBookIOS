//
//  SeachForUsersViewCOntroller.swift
//  CookBook
//
//  Created by Max Vitruk on 02.10.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class SeachForUsersViewCOntroller: UITableViewController, UISearchResultsUpdating {
    
    var candies = ["Mars","Snickers","KitKat","Lollipop","Roshen"]
    var filteredCandies = [String]()
    
    var resultSearchController : UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController?.searchResultsUpdater = self
        
        self.resultSearchController!.dimsBackgroundDuringPresentation = false
        self.resultSearchController?.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController?.searchBar
        
        // Reload the table
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController!.active {
            return self.filteredCandies.count
        } else {
            return self.candies.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchUserCell") as! SearchUserCell
        
        var candy : String
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if self.resultSearchController!.active {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        
        // Configure the cell
        cell.userName.text = candy
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredCandies.removeAll()
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.candies as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredCandies = array as! [String]
        
        self.tableView.reloadData()
        
    }
}
