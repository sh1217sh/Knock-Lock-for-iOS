//
//  KnockAuthenticator.swift
//  KnockLock
//
//  The MIT License. (MIT)
//  Copyright © 2009 Steve Hoefer. All rights reserved.
//
//  ********** ATTENTION! **********
//      Read License.txt first!
//  ********************************
//
//  Rewrote for iOS by Sung-ho Lee.
//

import Foundation

class KnockAuthanticator {
    
    // MARK: - Constants
    
    let REJECT_VALUE = 25
    let AVERAGE_REJECT_VALUE = 15
    
    // MARK: -
    
    // MARK: Data Processing
    
    private func normalize(code: KnockCode) -> KnockCode{
        
        // Get the maximum time interval to set it as a basis.
        var maxTime = 0
        for time in code.timeBetweenKnocks {
            if time > maxTime {
                maxTime = time
            }
        }
        
        // Caculate.
        var normalizedTime = [Int]()
        for i in 0..<code.count {
            normalizedTime.append(code.timeBetweenKnocks[i] * 100 / maxTime)
        }
        
        // Create a instance of normalized code and return it.
        return KnockCode(timeBetweenKnocks: normalizedTime)!
    }
    
    private func abs(val: Int) -> Int {
        if val < 0 {
            return val * -1
        } else{
            return val
        }
    }
    
    // MARK: Authentication
    
    func validateWithStroedCode(storedCode: KnockCode, inputtedCode: KnockCode) -> Bool {
        
        let knockCount = storedCode.count
        
        // Start with simple things. We compare the count.
        if knockCount != inputtedCode.count {
            return false
        }
        
        var totalTimeDifference = 0
        var timeDifferences = 0
        
        let normalizedStroedCode = normalize(storedCode)
        let normalizedInputtedCode = normalize(inputtedCode)
        
        // Compare individual knocks.
        for i in 0..<knockCount {
            timeDifferences = abs(normalizedStroedCode.timeBetweenKnocks[i] - normalizedInputtedCode.timeBetweenKnocks[i])
            if timeDifferences > REJECT_VALUE {
                return false
            }
            
            // Add time differences to compare average knock intervals.
            totalTimeDifference += timeDifferences
        }
        
        // Compare average knock interval.
        if (totalTimeDifference / knockCount > AVERAGE_REJECT_VALUE) {
            return false
        }
        
        // Return true if inputted code passes all the tests.
        return true
    }
    
}
