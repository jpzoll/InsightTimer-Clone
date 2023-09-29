//
//  Option.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/29/23.
//

import Foundation

// For main menu. As of now, there is only 1 option (the meditation timer demo)
struct Option: Identifiable {
    var id = UUID()
    let name: String
    let image_str: String
    var isShowing = false
}
