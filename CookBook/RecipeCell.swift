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
                let url = NSURL(string: photo.img.url!)
                recipeImage.getDataFromUrl(url!) { (data, response, error)  in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        guard let data = data where error == nil else { return }
                        self.recipeImage.image = UIImage(data: data)
                    }
                }
                recipeDescription.text = photo.comment
                recipeName.text = photo.caption
                self.headerContainer.backgroundColor = UIColor(hex: photo.img.hex!)
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
