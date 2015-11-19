//
//  MainLayout.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//

import Foundation
import UIKit


protocol PinterestLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath,
        withWidth:CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView,
        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0.0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if( attributes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class MainLayout : UICollectionViewLayout {

    var delegate: PinterestLayoutDelegate!
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    private var cache = [PinterestLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return PinterestLayoutAttributes.self
    }
    
    func getCellWidth()-> CGFloat {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            return 255
        }else{
            return 155
        }
    }
    
    override func prepareLayout() {
        print("prepareLayout")
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let mWidth = screenSize.width
        print("\(mWidth)")
        let w = self.getCellWidth()
        numberOfColumns = Int(mWidth/w)
        print("numberOfColumns : \(numberOfColumns)")
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        var column = 0
        var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
        
        self.invalidatePreviousData()
        
        for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
            
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            
            let width = columnWidth - cellPadding * 2
            let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath,
                withWidth:width)
            let annotationHeight = delegate.collectionView(collectionView!,
                heightForAnnotationAtIndexPath: indexPath, withWidth: width)
            let height = cellPadding +  photoHeight + annotationHeight + cellPadding + 20
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
            
            let attributes = PinterestLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.photoHeight = photoHeight
            
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, CGRectGetMaxY(frame))
            yOffset[column] = yOffset[column] + height
            
            column = column >= (numberOfColumns - 1) ? 0 : ++column
        }

    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
        
        //        var attributes = [UICollectionViewLayoutAttributes]()
        //        let sections = self.collectionView!.numberOfSections()
        //        for(var i=0 ; i < sections ; i++) {
        //            for (var j=0 ; j < self.collectionView!.numberOfItemsInSection(i) ; j++) {
        //                let indexPath = NSIndexPath(forItem: j, inSection: i)
        //                attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath)!)
        //            }
        //        }
        //        return attributes

    }
    
    func invalidatePreviousData(){
        cache.removeAll()
        contentHeight = 0
    }
}