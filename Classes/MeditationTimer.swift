//
//  Timer.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/27/23.
//

import Foundation

class MeditationTimer: ObservableObject {
    @Published var isRunning: Bool
    
    /// Timer
    @Published var hoursLeft: Int
    @Published var minutesLeft: Int
    @Published var secondsLeft: Int
    
    init(isRunning: Bool, hoursLeft: Int, minutesLeft: Int, secondsLeft: Int) {
        self.isRunning = isRunning
        self.hoursLeft = hoursLeft
        self.minutesLeft = minutesLeft
        self.secondsLeft = secondsLeft
    }
    
    func updateTime() {
        if self.isRunning {
            if self.secondsLeft > 0 {
        /// Decrement seconds if there are more than 0 seconds left
                self.secondsLeft -= 1
            } else if self.minutesLeft > 0 {
        /// Decrement minutes and reset seconds to 59 when seconds reach 0
                self.minutesLeft -= 1
                self.secondsLeft = 59
            } else if self.hoursLeft > 0 {
        /// Decrement hours, reset minutes and seconds to 59 when minutes reach 0
                self.hoursLeft -= 1
                self.minutesLeft = 59
                self.secondsLeft = 59
            } else {
        /// Timer and meditation are complete, **STOP** the timer!
                self.isRunning = false
        ///
        // END COUNTDOWN LOGIC
        ///
            }
        }
    }
    
}
