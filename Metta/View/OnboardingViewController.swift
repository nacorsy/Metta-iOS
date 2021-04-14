//
//  onboardingViewController.swift
//  Metta
//
//  Created by Novi Gunawan on 13/04/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var mediImage: UIImageView!

    private let storageManager = StorageManager()
    private let navigationManager = NavigationManager()
    
    @IBAction func nextButton(_ sender: UIButton) {
        navigationManager.show(screen: .home, inController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediImage.image = UIImage(named: "medi-intro")
        updateFlag()
    }
    
    func updateFlag() {
        storageManager.setOnBoardingSeen()
    }
}
