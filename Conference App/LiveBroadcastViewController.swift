//    Copyright (c) 2016, UWF
//    All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of UWF nor the names of its contributors may be used to
//    endorse or promote products derived from this software without specific
//    prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.
//
//  ViewController.swift
//  liveStream
//
//  Created by Julian L on 4/16/16.

import UIKit
import AVFoundation
import CoreMedia
import AVKit
import CoreData
import SystemConfiguration
import MediaPlayer

class LiveBroadcastViewController: UIViewController {
    
    // Launch empty timers and avplayers
    var player: AVPlayer?
    var timer = NSTimer()
    
    // Duration time in seconds
    var count: Int = 0
    var badStreamCount: Int = 0
    
    var session : AVAudioSession!
    
    
    @IBOutlet var broadcastTitle: UILabel!
    
    // Duration counter in (HH:MM:SS)
    @IBOutlet var hours: UILabel!
    @IBOutlet var minutes: UILabel!
    @IBOutlet var seconds: UILabel!
    
    // Starts the Audio Stream
    @IBAction func playAudio(sender: AnyObject) {
        startAudio()
        
        playButton.enabled = false
        playButton.alpha = 0.5
        
        pauseButton.enabled = true
        pauseButton.alpha = 1.0
    }
    
    // Pauses the Stream
    @IBAction func stopAudio(sender: AnyObject) {
        if let tempPlayer = player {
            tempPlayer.pause()
            player = nil
            onPause()
            timer.invalidate()
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = nil
        }
    }
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    
    /**
        Called when pause is performed. Responsable for reseting the timer and the counters.
     */

    private func onPause(){
        badStreamCount = 0
        count = 0
        hours.text = "00"
        minutes.text = "00"
        seconds.text = "00"
    
        pauseButton.enabled = false
        pauseButton.alpha = 0.5
        
        playButton.enabled = true
        playButton.alpha = 1.0
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UIConfig()
        pauseButton.alpha = 0.5
        pauseButton.enabled = false
        
        // This Code Lets the App Play MP3 in Background, Not Implemented Yet
        session = AVAudioSession.sharedInstance()
        
        do { try session.setCategory(AVAudioSessionCategoryPlayback) }
        catch { }
        
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        
        if event!.subtype == UIEventSubtype.RemoteControlPause {
            
            if let tempPlayer = player {
                tempPlayer.pause()
                player = nil
                onPause()
                timer.invalidate()
               // MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = nil
            }
            
            //pauseButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)

        } else if event!.subtype == UIEventSubtype.RemoteControlPlay {
            playButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
    }
    
    internal func UIConfig(){
        self.view.backgroundColor = ItenWiredStyle.background.color.mainColor
        self.broadcastTitle.textColor = ItenWiredStyle.text.color.mainColor
    }
    
    // Figures out the duration that the stream has been going, called by timer every second
    func audioDuration() {
        
        // Count = Number of Seconds Stream Running
        count = count + 1
        
        let time = secondsToHoursMinutesSeconds(count)
        
        // Format the time
        hours.text = String(format: "%02d", time.0)
        minutes.text = String(format: "%02d", time.1)
        seconds.text = String(format: "%02d", time.2)
        
        // Checks on the Status of the Audio Stream, and determines whether or not to disconnect
        if (self.player!.currentItem!.playbackLikelyToKeepUp == false)
        {
            // Stream is not likely to proceed
            badStreamCount = badStreamCount + 1
        }
        else if (self.player?.rate == 0.0) {
            // Internet Connection drops during stream
            badStreamCount = badStreamCount + 1
            player?.rate = 1.0
        }
        else {
            // Stream is successful, and will keep playing
            if (badStreamCount > 0) {
                badStreamCount = badStreamCount - 1
                
            }
        }
        
        // If the count of badStreamCount > 10, display an alert saying stream unavailable
        if badStreamCount > 10 {
            timer.invalidate()
            
            let noStream = UIAlertController(title: "Stream Unavailable", message: "Stream cannot be loaded or is unavailable at this time.", preferredStyle: UIAlertControllerStyle.Alert)
            
            noStream.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
               self.onPause()
            }))
            
            presentViewController(noStream, animated: true, completion: nil)
        }
    }
    
    // Starts the AVPlayer and NSTimer
    func startAudio() {
        
        if let player = player where player.rate != 0 {
            return
        }
        
        // Creates a timer that updates the duration labels (HH:MM:SS), calls audioDuration()
        let newtimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(LiveBroadcastViewController.audioDuration), userInfo: nil, repeats: true)
        timer.invalidate()
        timer = newtimer
        
        // Initiate the new AVPlayer instance
        
        
        // Pensacola Business Radio URL
        let url = "http://199.180.72.2:9110/;stream.mp3" //- Public Business Radio
        
        let playerItem = AVPlayerItem( URL:NSURL( string:url )! )
        player = AVPlayer(playerItem:playerItem)
        
        if let tempPlayer = player {
            tempPlayer.rate = 1.0;
            tempPlayer.play()
            let audioDictionary = [MPMediaItemPropertyTitle: "iTenWired - Live Broadcast" , MPMediaItemPropertyArtist:"Pensacola Business Radio"]
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = audioDictionary
        }
    }
    
    // Converts seconds to (HH:MM:SS) to display on screen
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    override func viewWillDisappear(animated: Bool) {
        // Restart timer when user leaves the application
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        if let splitController = self.splitViewController{
            if !splitController.collapsed {
                splitController.toggleMasterView()
                
            } else{
                let rightNavController = splitViewController!.viewControllers.first as! UINavigationController
                rightNavController.popToRootViewControllerAnimated(true)
            }
        }
    }
}

