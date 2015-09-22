//
//  KnockAuthenticator.swift
//  KnockLock
//
//  The MIT License. (MIT)
//  Copyright © 2009 Steve Hoefer. All rights reserved.
//
//  ********** ATTENTION! **********
//     Read LICENSE file first!
//  ********************************
//
//  Rewrote for iOS by Sung-ho Lee.
//


import Foundation

class KnockCode {
    
    // MARK: - Properties
    var timeBetweenKnocks: [Int]
    var count: Int
    
    // MARK: - Initialization
    
    init?(timeBetweenKnocks: [Int]) {
        self.timeBetweenKnocks = timeBetweenKnocks
        count = timeBetweenKnocks.count
        
        // It's quite not right if the count is same or less than 0. So initialization should be fail.
        if count <= 0 {
            return nil
        }
    }
    
}