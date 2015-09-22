//
//  ViewController.swift
//  KnockLockDemo
//
//  Created by Sung-ho Lee on 2015. 8. 17..
//
//  The MIT License
//  Copyright © 2015 Sung-ho Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KnockDetectorDelegate {
    
    // MARK: - Properties
    
    let sampleCode = KnockCode(timeBetweenKnocks: [50, 25, 25, 50, 100, 50])!
    var firstRun = true
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // We first have to lock the app when it is launched.
        if firstRun {
            lock()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - KnockDetector Delegate
    
    func knockFinishedWhithCode(code: KnockCode?) {
        
        if code != nil {
            let authenticator = KnockAuthanticator()
            let authResult = authenticator.validateWithStroedCode(sampleCode, inputtedCode: code!)
            
            if authResult {
                print("Authentication succeed")
                firstRun = false
                self.dismissViewControllerAnimated(false, completion: nil)
            }
            else {
                print("Authentication failed.")
            }
        }
    }
    
    // MARK: - Actions

    @IBAction func lock() {
        // Load knock lock detector view controller.
        let storyboard = UIStoryboard(name: "KnockLockStoryboard", bundle: nil)
        let detector = storyboard.instantiateViewControllerWithIdentifier("KnockDetectorViewController") as! KnockDetectorViewController
        detector.delegate = self
        detector.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        self.presentViewController(detector, animated: false, completion: nil)
    }

}

