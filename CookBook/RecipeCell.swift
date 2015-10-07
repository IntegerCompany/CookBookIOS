//
//  PhotoCell.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var recipeImage: UIImageView!

    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeOwnerName: UILabel!
    @IBOutlet weak var recipeOwnerPhoto: UIImageView!
    @IBOutlet weak var recipeLikesCounter: UILabel!
    
    var photo: Recipe? {
        didSet {
            if let photo = photo {
                recipeImage.image = photo.image
                recipeDescription.text = photo.comment
                recipeName.text = photo.caption
               // headerContainer.backgroundColor = self.getMeatRandomColor() //self.getRandomColor()
            }
        }
    }
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            recipeImageViewHeight.constant = attributes.photoHeight
        }
    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}
