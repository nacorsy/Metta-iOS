//
//  onboardingViewController.swift
//  Metta
//
//  Created by Novi Gunawan on 13/04/21.
//

import UIKit

class onboardingViewController: UIViewController {

    @IBOutlet weak var mediImage: UIImageView!
    
    @IBAction func nextButton(_ sender: UIButton) {
        
//        let vc = UIViewController()
//        vc.modalPresentationStyle = .fullScreen
        
        performSegue(withIdentifier: "onboardingToVCIdentifier", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediImage.image = UIImage(named: "medi-intro")

        // Do any additional setup after loading the view.
    }
    

    
    

}
