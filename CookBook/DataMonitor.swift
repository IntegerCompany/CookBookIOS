//
//  DataMonitor.swift
//  CookBook
//
//  Created by Max Vitruk on 13.11.15.
//  Copyright © 2015 integer. All rights reserved.
//

import Foundation

protocol DataMonitor {
    func updateGreedWithResponce(data : [Recipe])
    func updateCachedData(data : [Recipe])
}