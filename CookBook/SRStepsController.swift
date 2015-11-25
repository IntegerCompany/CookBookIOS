//
//  SRStepsController.swift
//  CookBook
//
//  Created by Max Vitruk on 24.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation
import UIKit

class SRStepsController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension SRStepsController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SRIStepsCell", forIndexPath: indexPath) as! SRIStepsCell
        cell.stepNumber.text = "\(indexPath.item + 1)"
        
        return cell
    }
}

extension SRStepsController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //selected 
    }
}