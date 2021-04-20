//
//  StorageManager.swift
//  Metta
//
//  Created by Novi Gunawan on 14/04/21.
//

import Foundation

class StorageManager {
    //punya List berbentuk enum Key
    enum Key: String {
        case isOnBoardingSeen
    }
    
    func isOnBoardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: Key.isOnBoardingSeen.rawValue )
    }
    
    func setOnBoardingSeen(){
        UserDefaults.standard.set(true, forKey: Key.isOnBoardingSeen.rawValue)
    }
    
    //Testing
    func resetOnboardingSeen() {
        UserDefaults.standard.set(false, forKey: Key.isOnBoardingSeen.rawValue)
    }
    
}
