//
//  ViewController.swift
//  StopWatch
//
//  Created by Ducky Duke.
//  Copyright © 2016 Duke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()

    var time: Int = 0       // milisecond
    let timeInterval = 1000  // milisecond
    
    @IBOutlet weak var timerLabel: UILabel!

    @IBOutlet weak var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentTime()
    }

    func increaseTime() {
        time += timeInterval
        displayCurrentTime()
    }

    // DRY: Don't repeat yourself
    func forceLength(value: Int, length: Int) -> String {
        var str = "\(value)"
        while str.characters.count < length {
            str = "0" + str
        }
        return str
    }

    func displayCurrentTime() {
        let minuteCount = time / 1000 / 60
        let minutesString = forceLength(minuteCount, length: 2)

        let secondCount = time / 1000 - minuteCount * 60
        let secondString = forceLength(secondCount, length: 2)



        let milisecondCount = time - (minuteCount * 60 + secondCount) * 1000
        let milisecondString = forceLength(milisecondCount, length: 3)

        timerLabel.text = minutesString + ":" + secondString + ":" + milisecondString
    }

    @IBAction func play(sender: AnyObject) {

        if timer.valid {
            timer.invalidate()
            changeFirstButtonTo(.Play)
        } else {
            changeFirstButtonTo(.Pause)
            timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(timeInterval/1000), target: self, selector:#selector(increaseTime), userInfo: nil, repeats: true)
        }
    }

    @IBAction func reset(sender: AnyObject) {
        if timer.valid {
            timer.invalidate()
        }
        time = 0
        displayCurrentTime()
    }

    func changeFirstButtonTo(style: UIBarButtonSystemItem) {
        let playButton = UIBarButtonItem(barButtonSystemItem: style, target: self, action: #selector(play(_:)))

        toolbar.items = [playButton, toolbar.items![1], toolbar.items![2]]
    }
}

