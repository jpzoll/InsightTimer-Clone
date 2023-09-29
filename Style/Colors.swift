//
//  Colors.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/28/23.
//

import Foundation
import SwiftUI

extension Color {
    //
    // ➡️ Custom Colors for Insight Timer
    //
    
    static let insightTimerColors = [
        Color(red: 39 / 255, green: 37 / 255, blue: 39 / 255),
        Color(red: 49 / 255, green: 47 / 255, blue: 50 / 255),
        // Home Page
        Color(red: 21 / 255, green: 23 / 255, blue: 22 / 255),
        Color(red: 31 / 255, green: 32 / 255, blue: 34 / 255)
    ]
    
    //
    // ➡️ Convert SwiftUI Color to UIColor
    //
    
    func uiColor() -> UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        }
        
        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    
    //
    // ➡️ Extract Color Components from SwiftUI Color
    //
    
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
