//
//  ViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import UIKit
import AVFoundation

class RecipeGridViewController : UICollectionViewController {
    
    var searchButton = UIButton(frame: CGRectMake(40,0,30, 30))
    
    var recipe = Recipe.allRecipes()
    
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
        
        self.initNavigationButtons()
        
        self.effectView = UIVisualEffectView (effect: blur)
        self.effectView.alpha = 0.9
        
        self.backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain , target: self, action: Selector("closeAction:"))
        
        if let layout = collectionView?.collectionViewLayout as? MainLayout {
            layout.delegate = self
        }
        
        view.backgroundColor = UIColor(netHex: 0xe6e6e6)
        
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecipeGridViewController : PinterestLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
        withWidth width:CGFloat) -> CGFloat {
            let photo = recipe[indexPath.item]
            let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect  = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
            return rect.size.height
    }
    
    //Mark : Here we are making a cell HEIGHT calculation
    func collectionView(collectionView: UICollectionView,
        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
            let annotationPadding = CGFloat(16)
            let annotationHeaderHeight = CGFloat(56)
            let photo = recipe[indexPath.item]
            let font = UIFont(name: "AvenirNext-Regular", size: 10)!
            let commentHeight = photo.heightForComment(font, width: width)
            let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
            return height
    }
}
extension RecipeGridViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipe.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
        cell.photo = recipe[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
                
                let h = self.selectedCell.frame.height * 2.5
                let w = self.selectedCell.frame.width * 2.5
                self.selectedCell.recipeImageViewHeight.constant *= 2.5
                let xPosition = self.view.center.x - (w/2)
                let yPosition = self.view.center.y - (h/2)
                self.selectedCell.frame = CGRect(x: screen.x + xPosition, y: screen.y + yPosition, width: w , height: h)
                self.effectView.alpha = 0.9
                
            }), completion: nil)
            
            
            collectionView.bringSubviewToFront(self.selectedCell)
            self.navigationItem.setLeftBarButtonItem(self.backButton, animated: false)
            self.isDeselected = false
        }else{
           self.performSegueWithIdentifier("openRecipeScreen", sender: self)
        }
        
        print("didSelectItemAtIndexPath")
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.isDeselected = true
        self.navigationItem.setLeftBarButtonItem(nil, animated: false)
        print("didDeselectItemAtIndexPath")
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

    func deselectSelectedCell(){
        UIView.animateWithDuration(0.3 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: ({
            
            if let index = self.collectionView?.indexPathForCell(self.selectedCell){
                self.collectionView(self.collectionView!, didDeselectItemAtIndexPath: index)
            }
            self.selectedCell.recipeImageViewHeight.constant /= 2.5
            self.selectedCell?.frame = self.oldFrame
            self.effectView.alpha = 0.0
            
        }), completion: { finished in
            self.effectView.removeFromSuperview()
        })
    }
    
    func closeAction(button : UIBarButtonItem){
        self.deselectSelectedCell()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearchOptions()
    }
    
    func showSearchOptions(sender : UIButton) {
//        searchButton.hidden = true
//        searchBar.hidden = false
//        searchBar.becomeFirstResponder()
    }
    func cancelSearchOptions() {
//        searchButton.hidden = false
//        searchBar.hidden = true
    }
    
    func initNavigationButtons(){
        
//        searchBar.delegate = self
//        searchBar.placeholder = "Search"
//        searchBar.hidden = true
//        searchBar.showsCancelButton = true
        let rightView = UIView(frame:  CGRectMake(0, 0, 80, 30))
        rightView.backgroundColor = UIColor.clearColor()
        
        searchButton.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        searchButton.tag=101
        searchButton.addTarget(self, action: "showSearchOptions:", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(searchButton)
        
        let leftNavBarButton = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
    }
}


