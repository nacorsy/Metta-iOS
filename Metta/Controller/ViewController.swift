//
//  ViewController.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 06/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnPressed(_ sender: UIButton) {
        let meditationTimerVC = MeditationTimerViewController(nibName: "MeditationTimerViewController", bundle: nil)
        meditationTimerVC.modalPresentationStyle = .fullScreen
        
        self.present(meditationTimerVC, animated: true, completion: nil)
    }
    
}

