//
//  UpdaterDelegate.swift
//  CookBook
//
//  Created by Dmytro Lohush on 11/11/15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation

@objc
protocol UpdaterProtocol{
  
  func getDataWithQuery(query : SearchObject , completionHandler : () -> Void)
  func writeCache()
  func updateView()
  func loadMore()
  
  optional func uploadDidFinish()
  optional func uploadDidStart()
}
