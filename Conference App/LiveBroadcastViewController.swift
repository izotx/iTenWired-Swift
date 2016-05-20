//
//  ViewController.swift
//  liveStream
//
//  Created by Julian L on 4/16/16.
//  Copyright © 2016 Julian Loftis. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import AVKit
import CoreData
import SystemConfiguration

class LiveBroadcastViewController: UIViewController {
    
    // Launch empty timers and avplayers
    var player: AVPlayer?
    var timer = NSTimer()
    
    // Duration time in seconds
    var count: Int = 0
    var badStreamCount: Int = 0
    
    
    @IBOutlet var broadcastTitle: UILabel!
    
    // Duration counter in (HH:MM:SS)
    @IBOutlet var hours: UILabel!
    @IBOutlet var minutes: UILabel!
    @IBOutlet var seconds: UILabel!
    
    // Starts the Audio Stream
    @IBAction func playAudio(sender: AnyObject) {
        startAudio()
    }
    
    // Pauses the Stream
    @IBAction func stopAudio(sender: AnyObject) {
        if let tempPlayer = player {
            tempPlayer.pause()
            player = nil
            count = 0
            hours.text = "00"
            minutes.text = "00"
            seconds.text = "00"
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UIConfig()
        // This Code Lets the App Play MP3 in Background, Not Implemented Yet
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        do { try session.setCategory(AVAudioSessionCategoryPlayback) }
        catch { }
        
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
            // print("Not likely - Count - \(count) - Bad Count - \(badStreamCount)")
        }
        else if (self.player?.rate == 0.0) {
            // Internet Connection drops during stream
            badStreamCount = badStreamCount + 1
            player?.rate = 1.0
            // print("Internet Drop - Count - \(count) - Bad Count - \(badStreamCount)")

        }
        else {
            // Stream is successful, and will keep playing
            if (badStreamCount > 0) {
                badStreamCount = badStreamCount - 1
                
            }
            // print("Likely - Count - \(count) - Bad Count - \(badStreamCount)")
        }
        
        // If the count of badStreamCount > 3, display an alert saying stream unavailable
        if badStreamCount > 3 {
            timer.invalidate()
            let noStream = UIAlertController(title: "Stream Unavailable", message: "Stream cannot be loaded or is unavailable at this time.", preferredStyle: UIAlertControllerStyle.Alert)
            
            noStream.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: { (action: UIAlertAction!) in
                self.count = 0
                self.badStreamCount = 0
                self.hours.text = "00"
                self.minutes.text = "00"
                self.seconds.text = "00"
            }))
            
            presentViewController(noStream, animated: true, completion: nil)
        }
        
    }
    
    // Starts the AVPlayer and NSTimer
    func startAudio() {
        
        // Creates a timer that updates the duration labels (HH:MM:SS), calls audioDuration()
        let newtimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(LiveBroadcastViewController.audioDuration), userInfo: nil, repeats: true)
        timer.invalidate()
        timer = newtimer
        
        // Initiate the new AVPlayer instance
        
        // WUWF Radio URL
        //let url = "http://pubint.ic.llnwd.net/stream/pubint_wuwfhd3"
        
        // Pensacola Business Radio URL
        //let url = "http://199.180.72.2:9110/;stream.mp3" //- Public Business Radio
        
        //let url = "http://199.180.72.2:9110/home.html"
        
        // Random Weather Radio URL for testing
        let url = "http://audiostream.wunderground.com/2000grandprix/cedarfalls.mp3.m3u"
        
        let playerItem = AVPlayerItem( URL:NSURL( string:url )! )
        player = AVPlayer(playerItem:playerItem)
        
        if let tempPlayer = player {
            tempPlayer.rate = 1.0;
            tempPlayer.play()
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

