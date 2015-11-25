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

    @IBOutlet weak var textRect: UIView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeOwnerName: UILabel!
    @IBOutlet weak var recipeOwnerPhoto: UIImageView!
    @IBOutlet weak var recipeLikesCounter: UILabel!
    
    var photo: Recipe? {
        didSet {
            if let photo = photo {
                recipeDescription.text = photo.comment
                recipeName.text = photo.caption
                let color = UIColor(hex: photo.img.hex!)
                recipeName.textColor = color
                self.headerContainer.backgroundColor = color
                
                textRect.layer.borderWidth = 1.0
                textRect.layer.borderColor = color.CGColor
            }
        }
    }
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            recipeImageViewHeight.constant = attributes.photoHeight
        }
    }
}
