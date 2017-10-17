//
//  AudioManager.swift
//  Hedgehog Dash
//
//  Created by Luke on 6/14/15.
//  Copyright (c) 2015 Puzzled. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager : AVAudioPlayer, AVAudioPlayerDelegate {
    
    var musicPlayer:AVAudioPlayer!
    var effectPlayer:AVAudioPlayer!
    
    func playMusic(music:String) {
        let musicFilePath = NSBundle.mainBundle().URLForResource(music, withExtension: "mp3")
        
        if musicFilePath != nil {
            
            
                do {
                    try musicPlayer = AVAudioPlayer(contentsOfURL: musicFilePath!)
                } catch {
                    //Handle the error
                }
            
             musicPlayer.numberOfLoops = 999;
             musicPlayer.play();
        }
    }
    
    func playSound(effect:String) {
        
        let audioFilePath = NSBundle.mainBundle().URLForResource(effect, withExtension: "mp3")
        
        if audioFilePath != nil {
            
            do {
                try effectPlayer = AVAudioPlayer(contentsOfURL: audioFilePath!)
            } catch {
                //Handle the error
            }

            effectPlayer.play();
            
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
    }
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
    }
    
    //func audioPlayerEndInterruption(player: AVAudioPlayer!) {
    //}
}