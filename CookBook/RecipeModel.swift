//
//  RecipeCell.swift
//  CookBook
//
//  Created by Max Vitruk on 31.08.15.
//  Copyright (c) 2015 integer. All rights reserved.
//


import UIKit
import RealmSwift
import Parse


class GridImage {
    var url : String?
    var hex : String?
    var w : Int?
    var h : Int?
    var rect : CGSize {
        get{
            return CGSize(width: w!, height: h!)
        }
        set(newRect){
            self.w = Int(newRect.width)
            self.h = Int(newRect.height)
        }
    }
    
    init(url : String, hex : String, newRect : CGSize ){
        self.url = url
        self.hex = hex
        self.rect = newRect
        
    }

    required init() {
        self.url = ""
        self.hex  = "#F57F17"
        rect = CGSize(width: 200,height: 1400)
        
    }
}

class Recipe {
    
    //Mark temp method
    class func allRecipes() -> [Recipe] {
        var photos = [Recipe]()
        if let URL = NSBundle.mainBundle().URLForResource("Photos", withExtension: "plist") {
            if let photosFromPlist = NSArray(contentsOfURL: URL) {
                for dictionary in photosFromPlist {
                    let photo = Recipe(dictionary: dictionary as! NSDictionary)
                    photos.append(photo)
                }
            }
        }
        return photos
    }
    
    class func transformToRecipe(objects : [PFObject])-> [Recipe]{
        print("Recipe : START transforming : \(NSDate().timeIntervalSince1970)")
        var recipes = [Recipe]()
        for obj in objects {
            recipes.append(Recipe(obj: obj))
        }
        print("Recipe : STOP transforming : \(NSDate().timeIntervalSince1970)")
        return recipes
    }
    
    var caption: String
    var comment: String
    var image: UIImage?
    var img : GridImage
    
    required init(){
        self.caption = "Some 1"
        self.comment = ""
        self.img = GridImage()
    }
    init(caption: String, comment: String, image: UIImage?) {
        self.caption = caption
        self.comment = comment
        self.image = image
        self.img = GridImage()
    }
    
    init(caption: String, comment: String, image: UIImage? ,img : GridImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
        self.img = img
    }
    
    convenience init(dictionary: NSDictionary) {
        let caption = dictionary["Caption"] as? String
        let comment = dictionary["Comment"] as? String
        let photo = dictionary["Photo"] as? String
        let image = UIImage(named: photo!)?.decompressedImage
        self.init(caption: caption!, comment: comment!, image: image!)
    }
    convenience init(obj : PFObject){
        let caption = obj.valueForKey("dishName") as! String
        let comment = obj.valueForKey("description") as! String
        let img = obj.valueForKey("gridImage")
        let resolution = img!.valueForKey("resolution") as! NSArray
        let rect = CGSize(width: (resolution[0] as! NSString).integerValue, height: (resolution[1] as! NSString).integerValue)
        let gridImg = GridImage(url: img!.valueForKey("url") as! String , hex: img!.valueForKey("color") as! String, newRect: rect)
        self.init(caption: caption, comment: comment, image: nil ,img : gridImg)
    }
    
    convenience init(savedRecipe : SavedRecipe){
        let rect = CGSize(width: savedRecipe.w, height: savedRecipe.h)
        let gridImg = GridImage(url: savedRecipe.url as String , hex: savedRecipe.hex as String, newRect: rect)
        self.init(caption: savedRecipe.caption as String, comment: savedRecipe.comment as String, image: UIImage(data: savedRecipe.image)!,img : gridImg)
    }
    
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: comment).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
}

class SavedRecipe : Object {
    dynamic var url : NSString!
    dynamic var hex : NSString!
    dynamic var w = 200
    dynamic var h = 600
    dynamic var caption: NSString!
    dynamic var comment: NSString!
    dynamic var image: NSData!
}
