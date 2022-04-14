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
        if files.contains(url){
            return
        }else{
            files.append(url)
        }
        player = AudioPlayer(url: url, buffered: false)
        player.isLooping = true
        mixer.addInput(player)
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
