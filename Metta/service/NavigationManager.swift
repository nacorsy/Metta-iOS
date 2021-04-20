//
//  NavigationManager.swift
//  Metta
//
//  Created by Novi Gunawan on 14/04/21.
//

import UIKit

class NavigationManager {
    //punya list enum Screen
    enum Screen {
        case onBoarding
        case home
        
    }
    
    func show(screen: Screen, inController: UIViewController!) {
        var viewController: UIViewController!
        switch screen {
        
        case .onBoarding:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "onboardingViewController")
            
        case .home:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NavigationController")
            
        }
        
        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
