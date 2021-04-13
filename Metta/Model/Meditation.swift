//
//  Meditation.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 08/04/21.
//

import Foundation

struct Meditation: Codable {
    let id: Int
    let name: String
    let caption: String
    let description: String
    let isDaily: Bool
    let totalSession: Int
    var currentSession: Int
    let minDuration: Int
}
