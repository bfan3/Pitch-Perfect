//
//  PlaySoundsViewController.swift
//  FirstDemo
//
//  Created by Bowen Fan on 4/7/15.
//  Copyright (c) 2015 Bowen Fan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Fields
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    /**
        Click button to play slow mode
    */
    @IBAction func playSlowMode(sender: UIButton) {
        playAudioWithSpeed(0.5)
    }
    
    /**
        Click button to play fast mode
    */
    @IBAction func playFastMode(sender: UIButton) {
        playAudioWithSpeed(1.5)
    }
    
    /**
        Playing audio with the given speed
    
        :param: The speed rate for playing an audio
    */
    func playAudioWithSpeed(speed: Float){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    /**
        Click button to play audio like a chipmunk
    */
    @IBAction func playChipmunkAudio(sender: UIButton) {
        //make it constant
        playAudioWithVariablePitch(1000)
    }
    
    /**
        Click button to play audio like a Darth Vader
    */
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    /**
        Playing audio with the given pitch
    
        :param: The pitch level for playing an audio
    */
    func playAudioWithVariablePitch(pitch: Float){
        
        stopAudio()//Stops all the audio that is currently playing
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    /**
        The stop button. Click to stop playing audio
    */
    @IBAction func stopPlayingAudio(sender: UIButton) {
        stopAudio()
    }
    
    /**
        By calling this function, it stops all the audio that is currently playing
    */
    func stopAudio(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }


}
