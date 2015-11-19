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
    func cacheData(recipes : [Recipe]){
        try! self.realm!.write {
            self.realm!.deleteAll()
            for item in recipes {
                let saved = SavedRecipe()
                saved.h = item.img.h!
                saved.w = item.img.w!
                saved.caption = item.caption
                saved.comment = item.comment
                saved.url = item.img.url
                saved.hex = item.img.hex
                if item.image != nil {
                    saved.image = UIImagePNGRepresentation(item.image!)
                }
                self.realm!.add(saved)
            }
            self.commitWriting()
        }
    }
    
    func getDataFromCache(){
        var returnType = [Recipe]()
        if !(self.realm!.isEmpty){
            if let recipes = self.realm?.objects(SavedRecipe) {
                for item in recipes {
                    let newRecipe = Recipe(savedRecipe: item)
                    returnType.append(newRecipe)
                }
            }
        }
        self.monitor?.updateCachedData(returnType)
    }
    
    func commitWriting(){
        try! self.realm?.commitWrite()
    }
        
    func isCacheEmpty() ->Bool {
        return self.realm!.isEmpty
    }
    func analyzeCacheSize()->Int{
        let recipes = realm!.objects(SavedRecipe)
        return recipes.count
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