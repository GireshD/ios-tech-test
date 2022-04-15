//
//  RechordViewModel.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//

import Foundation
import AudioKit

class RechordViewModel {
    var engine: AudioEngine = AudioEngine()
    var mixer: Mixer = Mixer()

    var player: AudioPlayer!
    private var files: [URL] = []
        
    func loadAudio(from url: URL) {
        if (player != nil) { stop() }
        player = AudioPlayer(url: url)
        mixer.addInput(player)
    }
    
    func looping(){
        player.isLooping = true
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.stop()
    }
        
    func startEngine() {
        engine.output = mixer
        
        try? engine.start()
        mixer.start()
    }
    
    func stopEngine() {
        mixer.stop()
        engine.stop()
    }
}
