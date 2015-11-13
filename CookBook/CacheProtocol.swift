//
//  CacheDelegate.swift
//  CookBook
//
//  Created by Dmytro Lohush on 11/11/15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation

protocol CacheProtocol {
  func cacheData(recipe : Recipe)
  func getDataFromCache()->[Recipe]
  func isCacheEmpty()->Bool
  func clearCache()
  func analyzeCacheSize()->Int
  func optimizeCacheSize()
}