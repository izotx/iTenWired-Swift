//
//  TrackData.swift
//  Conference App
//
//  Created by Felipe on 5/20/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class TrackData{

    let appData = AppData()
    
    func getAllTracks() -> [Track]{
    
        var tracks:[Track] = []
        
        let data = appData.getDataFromFile()
        
        if let tracksData = data["tracks"] as? [NSDictionary]{
            for trackData in tracksData{
                let track = Track(dictionary: trackData)
                tracks.append(track)
            }
        }
        return tracks
    }
    
    func getTrackById(id:Int) -> Track?{
        for track in self.getAllTracks(){
            if track.id == id{
                return track
            }
        }
        return nil
    }
    
}