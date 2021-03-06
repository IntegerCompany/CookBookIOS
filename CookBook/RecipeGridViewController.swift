//
//  ViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

class RecipeGridViewController : UICollectionViewController {
    //Mark : Hardcoded cache
    var recipe = [Recipe]()
    
    var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    var effectView:UIVisualEffectView!
    
    var oldFrame : CGRect!
    var oldPosition : CGPoint!
    var selectedCell : RecipeCell!
    var isDeselected : Bool = true
    var backButton : UIBarButtonItem!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Updater.getUpdaterInstance().defaultUpdate()
        print("Cache size : \(Cache.getCacheInstance().analyzeCacheSize())")
        //Setting updater callback
        Updater.getUpdaterInstance().monitor = self
        Cache.getCacheInstance().monitor = self
        Cache.getCacheInstance().getDataFromCache()
        
        self.effectView = UIVisualEffectView (effect: blur)
        self.effectView.alpha = 0.9
        
        self.backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain , target: self, action: Selector("closeAction:"))
        
        if let layout = collectionView?.collectionViewLayout as? MainLayout {
            layout.delegate = self
        }
        
        view.backgroundColor = UIColor(netHex: 0xe6e6e6)
        collectionView!.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !self.isDeselected {
            self.deselectSelectedCell()
        }
        navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        Cache.getCacheInstance().cacheData(self.recipe)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark : prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openRecipeScreen" {
            let vc = segue.destinationViewController as! SingleRecipeViewController
            vc.recipe = self.recipe[sender as! Int]
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        guard let flowLayout = self.collectionViewLayout as? MainLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
}

extension RecipeGridViewController : PinterestLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
        withWidth width:CGFloat) -> CGFloat {
            let photo = recipe[indexPath.item]
            let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect  = AVMakeRectWithAspectRatioInsideRect(photo.img.rect, boundingRect)
            return rect.size.height
    }
    
    //Mark : Here we are making a cell HEIGHT calculation
    func collectionView(collectionView: UICollectionView,
        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
            let annotationPadding = CGFloat(16)
            let annotationHeaderHeight = CGFloat(64)
            let photo = recipe[indexPath.item]
            let commentFont = UIFont(name: "AvenirNext-Regular", size: 12)!
            let commentHeight = photo.heightForComment(commentFont, width: width - 22)
            let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding + 20
            return height
    }
}
//MARK: DataMonitor
extension RecipeGridViewController : DataMonitor {
    func updateGreedWithResponce(data: [Recipe]) {
        update(data)
    }
    
    func updateCachedData(data : [Recipe]){
        update(data)
    }
    
    func update(data : [Recipe]){
        self.recipe = data
        self.collectionView?.reloadData()
    }
}
extension RecipeGridViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recipe.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
        
        cell.photo = recipe[indexPath.item]
        if cell.photo?.image == nil{
            let url = NSURL(string: cell.photo!.img.url!)
            
            cell.recipeImage.getDataFromUrl(url!) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    let toImage = UIImage(data: data)
                    self.recipe[indexPath.item].image = toImage
                    //Fade transaction
                    UIView.transitionWithView(cell.recipeImage ,
                        duration: 0.5,
                        options: UIViewAnimationOptions.TransitionCrossDissolve,
                        animations: { cell.recipeImage.image = toImage },
                        completion: nil)
                    cell.recipeImage.image = toImage
                }
            }
        }else{
            let img = cell.photo!.image
            cell.recipeImage.image = img
            self.recipe[indexPath.item].image = img
        }

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.scaleCell(collectionView, indexPath: indexPath)
        }else{
            self.performSegueWithIdentifier("openRecipeScreen", sender: indexPath.item)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.isDeselected = true
        self.navigationItem.setLeftBarButtonItem(nil, animated: false)
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if !self.isDeselected {
            if self.selectedCell == cell {
                self.isDeselected = true
                self.deselectSelectedCell()
                self.navigationItem.setLeftBarButtonItem(nil, animated: false)
            }
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.deselectSelectedCell()
    }
    
    func scaleCell(collectionView : UICollectionView, indexPath : NSIndexPath){
        if isDeselected {
            self.selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! RecipeCell
            self.oldFrame = selectedCell.frame
            
            let screen = collectionView.contentOffset
            self.effectView.frame = CGRect(x: -5.0, y: -25.0 , width: collectionView.frame.width, height: collectionView.contentSize.height + 35.0)
            collectionView.addSubview(self.effectView)
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            self.effectView.addGestureRecognizer(tap)
            self.effectView.alpha = 0.0
            
            UIView.animateWithDuration(0.6 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: ({
                
                let h = self.selectedCell.frame.height * 1.8
                let w = self.selectedCell.frame.width * 1.8
                self.selectedCell.recipeImageViewHeight.constant *= 1.8
                let xPosition = self.view.center.x - (w/2)
                let yPosition = self.view.frame.origin.y + 25
                self.selectedCell.frame = CGRect(x: screen.x + xPosition, y: screen.y + yPosition, width: w , height: h)
                self.effectView.alpha = 0.9
                
            }), completion: nil)
            
            collectionView.bringSubviewToFront(self.selectedCell)
            self.navigationItem.setLeftBarButtonItem(self.backButton, animated: false)
            self.isDeselected = false
        }else{
            self.performSegueWithIdentifier("openRecipeScreen", sender: indexPath.item)
        }

    }

    func deselectSelectedCell(){
        UIView.animateWithDuration(0.3 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: ({
            
            if let index = self.collectionView?.indexPathForCell(self.selectedCell){
                self.collectionView(self.collectionView!, didDeselectItemAtIndexPath: index)
            }
            self.selectedCell.recipeImageViewHeight.constant /= 1.8
            self.selectedCell?.frame = self.oldFrame
            self.effectView.alpha = 0.0
            
        }), completion: { finished in
            self.effectView.removeFromSuperview()
        })
    }
    
    func closeAction(button : UIBarButtonItem){
        self.deselectSelectedCell()
    }
}


