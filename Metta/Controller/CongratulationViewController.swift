//
//  CongratulationViewController.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 13/04/21.
//

import UIKit

class CongratulationViewController: UIViewController {
    
    var runCount = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timerCounter() {
        runCount += 1
        
        if runCount == 5 {
            timer.invalidate()
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }

}
