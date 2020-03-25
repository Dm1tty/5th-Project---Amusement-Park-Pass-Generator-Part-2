//
//  AudioPlayer.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import Foundation
import AVFoundation

class Sounds {
    
    // A sound is being played when a pass swipes at the kiosk
    var sound: AVAudioPlayer?
    
    func playSound (soundName: String) {
        do{
            //Create a URL from a path
            if let fileURL = Bundle.main.path(forResource: soundName, ofType: "wav") {
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("Error: No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        sound?.play()
    }
}

