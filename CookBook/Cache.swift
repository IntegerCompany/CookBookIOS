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
    var realm : Realm?
    
    init(){
        do{
            self.realm = try! Realm()
        }catch _ {}
    }
    
    internal static func getCache()-> Cache {
        return self.cache
    }
}

extension Cache : CacheProtocol {
    func cacheData(recipe : Recipe){
        try! self.realm!.write {
            self.realm!.add(recipe)
        }
    }
    func getDataFromCache()-> [Recipe] {
        var returnType = [Recipe]()
        if let recipes = self.realm?.objects(Recipe) {
            for i in recipes {
                returnType.append(i)
            }
        }
        return returnType
    }
    func isCacheEmpty()->Bool{
        let recipes = self.realm!.objects(Recipe)
        if recipes.count == 0 {
            return false
        }else{
           return true
        }
    }
    func analyzeCacheSize()->Int{
        
        return 0
    }
    func optimizeCacheSize(){
        
    }
    func clearCache(){
        try! self.realm!.write {
            self.realm!.deleteAll()
        }
        print("Cache has been deleted !")
    }
}