
//
//  NRBlendedModel.swift
//  CookBook
//
//  Created by Max Vitruk on 26.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation
import UIKit

protocol NRBObject {
    func getContent()->AnyObject
}
struct NRBlendedModelText : NRBObject {
    var text : NSString?
    
    init(text : String){
        self.text = text
    }
    
    func getContent()->AnyObject{
        if let x = text {
            return x
        }else{
            return ""
        }
    }
}
struct NRBlendedModelImage : NRBObject {
    var img : UIImage?
    
    init(image : UIImage){
        self.img = image
    }
    
    func getContent()->AnyObject{
        if let i = img {
            return i
        }else{
            return UIImage()
        }
    }
}