//
//  SRIngedientsController.swift
//  CookBook
//
//  Created by Max Vitruk on 23.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit
typealias SRIC = SRIngredientController
class SRIngredientController : UIViewController {
    
    @IBOutlet weak var SRIContainer: UIView!
    
    @IBOutlet weak var _SRIContainerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipe : Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.scrollEnabled = true
        self.SRIContainer.layer.borderWidth = 1.0
        self.SRIContainer.layer.borderColor = UIColor.darkGrayColor().CGColor
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SRIC : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SRIngredientCell") as! SRIngredientCell
        cell.amount.text = "140 g."
        cell.ingredient.text = "Iron"

        self._SRIContainerHeight.constant += cell.frame.height
        
        return cell
    }
}

extension SRIC : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Ingredient : selected : \(indexPath.item) row")
    }
}