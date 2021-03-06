//
//  Cells.swift
//  CookBook
//
//  Created by Max Vitruk on 02.10.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class SearchUserCell : UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: RoundedImageView!

}

class SRIStepsCell : UICollectionViewCell {
    @IBOutlet weak var stepNumber: UILabel!
    @IBOutlet weak var stepImage: UIImageView!
}

class SRIngredientCell : UITableViewCell {
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var amount: UILabel!
    
}
