//
//  loadingViewController.swift
//  Metta
//
//  Created by Novi Gunawan on 14/04/21.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var isOnboardingSeen: Bool!
    
    private let storageManager = StorageManager()
    private let navigationManager = NavigationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnboardingSeen = storageManager.isOnBoardingSeen()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    func showInitialScreen()   {
      
        if isOnboardingSeen {
            //straight go to home-page
            navigationManager.show(screen: .home, inController: self)
        }
        else{
            //go to onboarding screen first
            navigationManager.show(screen: .onBoarding, inController: self)
        }
    }
  
}
