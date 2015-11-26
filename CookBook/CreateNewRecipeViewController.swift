//
//  CreateNewRecipeViewController.swift
//  CookBook
//
//  Created by Max Vitruk on 24.09.15.
//  Copyright © 2015 integer. All rights reserved.
//

import UIKit

class CreateNewRecipeViewController: UIViewController {

    @IBOutlet weak var launchCountainer: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.launchCountainer.hidden = false
        self.mainView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCreateButton(sender: RoundedButton) {
        self.launchCountainer.hidden = true
        self.mainView.hidden = false
        
        self.performSegueWithIdentifier("goNRTableBlemnderController", sender: self)
    }

    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    class func combine(images: UIImage...) -> UIImage {
        var contextSize = CGSizeZero
        
        for image in images {
            contextSize.width = max(contextSize.width, image.size.width)
            contextSize.height = max(contextSize.height, image.size.height)
        }
        
        UIGraphicsBeginImageContextWithOptions(contextSize, false, UIScreen.mainScreen().scale)
        
        for image in images {
            let originX = (contextSize.width - image.size.width) / 2
            let originY = (contextSize.height - image.size.height) / 2
            
            image.drawInRect(CGRectMake(originX, originY, image.size.width, image.size.height))
        }
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return combinedImage
    }

}
