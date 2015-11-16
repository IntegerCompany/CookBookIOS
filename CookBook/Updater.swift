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
        monitor?.updateGreedWithResponce([Recipe]())
        
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