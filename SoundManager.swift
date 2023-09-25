//
//  SoundManager.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/25/23.
//

import Foundation
import AVKit

class SoundManager {
    private var sound: AVAudioPlayer?
    
    init() {
        //guard let url = URL(string: "Sounds/tibetan-bell-sound.mp3") else { return }
        guard let url = Bundle.main.url(forResource: "tibetan-bell-sound", withExtension: ".mp3") else {return}
        
        if let player = try? AVAudioPlayer(contentsOf: url) {
            sound = player
            return
        }
        
        sound = nil
    }
    
    func playSound() {
        sound?.play()
    }
}
