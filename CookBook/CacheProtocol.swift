//
//  CacheDelegate.swift
//  CookBook
//
//  Created by Dmytro Lohush on 11/11/15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation
import RealmSwift

protocol CacheProtocol {
  func cacheData(recipe : Object)
  func getDataFromCache()
  func isCacheEmpty()->Bool
  func clearCache()
  func analyzeCacheSize()->Int
  func optimizeCacheSize()
}