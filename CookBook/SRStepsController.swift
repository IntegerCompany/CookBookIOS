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
    var urls = [NSURL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.urls = allURLS()
    }
    
    func allURLS() -> [NSURL] {
        var photos = [NSURL]()
        if let URL = NSBundle.mainBundle().URLForResource("ImageURLS", withExtension: "plist") {
            if let photosFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in photosFromPlist {
                    let photo = NSURL(string: dictionary as! String)
                    photos.append(photo!)
                }
            }
        }
        return photos
    }
}

extension SRStepsController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SRIStepsCell", forIndexPath: indexPath) as! SRIStepsCell

        if indexPath.item == 0 {
            cell.stepNumber.text = "Let's go"
        }else{
            cell.stepNumber.text = "\(indexPath.item)"
            let url = self.urls[indexPath.item-1]
            cell.stepImage.getDataFromUrl(url) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    cell.stepImage.image = UIImage(data: data)
                }
            }

        }

        
        return cell
    }
}

extension SRStepsController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //selected 
    }
}