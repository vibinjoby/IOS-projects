//
//  TestViewController.swift
//  TableViewWithMultipleCells
//
//  Created by vibin joby on 2019-11-17.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

import SRCountdownTimer
class TestViewController: UIViewController,SRCountdownTimerDelegate  {

    @IBOutlet weak var countdownTimer: SRCountdownTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownTimer.delegate = self
        countdownTimer.labelFont = UIFont(name: "HelveticaNeue-Light", size: 50.0)
        countdownTimer.labelTextColor = UIColor.black
        countdownTimer.timerFinishingText = "Time Up"
        countdownTimer.lineWidth = 10
        countdownTimer.trailLineColor = UIColor.lightGray.withAlphaComponent(0.5)
        countdownTimer.start(beginingValue: 15, interval: 1)
        // Do any additional setup after loading the view.
    }
    
    func timerDidEnd() {
        print("am done")
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
