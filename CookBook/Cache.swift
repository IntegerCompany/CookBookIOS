//
//  Cache.swift
//  CookBook
//
//  Created by Max Vitruk on 11.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation
import RealmSwift

// The main function of this class is self explanatory. This class makeing cache using RealmDB
// See RealmSwift. https://realm.io/docs/swift

class Cache {
    private static let cache = Cache()
    private var realm : Realm?
    var monitor : DataMonitor?
    
    private init(){
        do{
            self.realm = try! Realm()
        }catch _ {}
    }
    
    internal static func getCacheInstance()-> Cache {
        return self.cache
    }
}

extension Cache : CacheProtocol {
    func cacheData(recipe : Object){
        try! self.realm!.write {
            self.realm!.add(recipe)
        }
    }
    
    func getDataFromCache(){
        let returnType = [AnyObject]()
        if !(self.realm!.isEmpty){
            if let recipes = self.realm?.objects(Object) {
                //            for i in recipes {
                //                returnType.append(i)
                //            }
                //        }
            }
        }
        self.monitor?.updateCachedData(returnType)
    }
        
    func isCacheEmpty() ->Bool {
        return self.realm!.isEmpty
    }
    func analyzeCacheSize()->Int{
        return 0
    }
    func optimizeCacheSize(){
        print("Cache : cache has been optimized !")
    }
    func clearCache(){
        try! self.realm!.write {
            self.realm!.deleteAll()
        }
        print("Cache has been deleted !")
    }
}