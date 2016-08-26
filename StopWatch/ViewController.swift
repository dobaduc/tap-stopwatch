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

    var time: Int = 0

    var timeInterval = 1000 // milisecond
    
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

    func displayCurrentTime() {
        let minuteCount = time / timeInterval / 60
        let minutesString = minuteCount < 10 ? "0\(minuteCount)" : "\(minuteCount)"

        let secondCount = time / timeInterval - minuteCount * 60
        let secondsString = secondCount < 10 ? "0\(secondCount)" : "\(secondCount)"

        timerLabel.text = minutesString + ":" + secondsString
    }

    @IBAction func play(sender: AnyObject) {

        if timer.valid {
            timer.invalidate()
            changeFirstButtonTo(.Play)
        } else {
            changeFirstButtonTo(.Pause)
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(increaseTime), userInfo: nil, repeats: true)
        }
    }

    @IBAction func reset(sender: AnyObject) {
        timer.invalidate()
        time = 0
        displayCurrentTime()
    }

    func changeFirstButtonTo(style: UIBarButtonSystemItem) {
        let playButton = UIBarButtonItem(barButtonSystemItem: style, target: self, action: #selector(play(_:)))

        toolbar.items = [playButton, toolbar.items![1], toolbar.items![2]]
    }
}
