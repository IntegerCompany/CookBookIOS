//
//  Updater.swift
//  CookBook
//
//  Created by Max Vitruk on 13.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation
import Parse

class SearchQuery {
    init(){
        
    }
}
class Updater {
    private static let updater = Updater()
    var monitor : DataMonitor?
    
    private init(){
        
    }
     
    internal static func getUpdaterInstance()->Updater{
        return self.updater
    }
    
    func defaultUpdate(){
        //ParseQuery<ParseObject> query = ParseQuery.getQuery(ParseKey.RECIPE);
//        query.include(ParseKey.Recipe.GRID_IMAGE);
//        query.findInBackground(new FindCallback<ParseObject>() {
//            public void done(List<ParseObject> scoreList, ParseException e) {
//                if (e == null) {
//                    ArrayList<ParseObject> arrayList = new ArrayList<>();
//                    Log.d("score", "Retrieved: " + scoreList.size());
//                    
//                    for (ParseObject parseObject : scoreList) {
//                        arrayList.add(parseObject);
//                    }
//                    adapter.add(arrayList);
//                } else {
//                    Log.d("score", "Error: " + e.getMessage());
//                }
//            }
//            });
        let query = PFQuery(className:"Recipe")
        query.includeKey("gridImage")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                print(objects)
                let recipes = Recipe.transformToRecipe(objects!)
                self.monitor?.updateGreedWithResponce(recipes)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}

extension Updater : UpdaterProtocol {
    @objc func getDataWithQuery(query : SearchObject , completionHandler : () -> Void){
        
    }
    @objc func writeCache(){
        
    }
    @objc func updateView(){
        
    }
    @objc func loadMore(){
        
    }
}