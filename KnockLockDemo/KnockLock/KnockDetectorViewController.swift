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


import UIKit

protocol KnockDetectorDelegate {
    func knockFinishedWhithCode(code: KnockCode?)
}

class KnockDetectorViewController: UIViewController {
    
    // MARK: - Properties
    
    let EXPIRE_TIME: Float = 1.2 // Expire time in second.
    let TIMER_INTERVAL: NSTimeInterval = 0.01 // Timer interver in second.
    
    var timer: NSTimer = NSTimer()
    var isFirstKnock: Bool = true
    var currentTime: Float = 0 // Stores time between two knocks.
    var timeBetweenKnocks: [Int] = [Int]() // Stores final knock info.
    
    var delegate: KnockDetectorDelegate? = nil
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Timer
    
    func updateCurrentTime() {
        currentTime += Float(TIMER_INTERVAL)
        
        // If currentTime > 1.2 seconds, stop the timer and end input sequence.
        if currentTime > EXPIRE_TIME {
            endInputSequence()
        }
    }
    
    func endInputSequence() {
        timer.invalidate()
        currentTime = 0
        isFirstKnock = true
        print("Knock ended. The code is: \(timeBetweenKnocks)")
        
        if delegate != nil {
            // Send data.
            delegate!.knockFinishedWhithCode(KnockCode(timeBetweenKnocks: timeBetweenKnocks))
        }
    }

    // MARK: - Actions
    @IBAction func addNewKnock(sender: UITapGestureRecognizer) {
        if isFirstKnock {
            // We want the storage to be cleared.
            timeBetweenKnocks = [Int]()
            
            // Start the timer.
            timer = NSTimer.scheduledTimerWithTimeInterval(TIMER_INTERVAL, target: self, selector: "updateCurrentTime", userInfo: nil, repeats: true)
            
            isFirstKnock = false
            
            print("Knock started.")
        } else {
            print(currentTime)
            timeBetweenKnocks.append(Int(currentTime * 100))
            currentTime = 0
        }
    }
    
}

