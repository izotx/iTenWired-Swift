//
//  AttendeeData.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class AttendeeData{
    
    private let appData = AppData()
    
    private var sponsers:[Sponser] = []
    private var exibitors:[Exibitor] = []
    private var speakers:[Speaker] = []

    
    init(){
        loadSponsers()
        loadExibitors()
        loadSpeakers()
    }
    
    // Loads sponsers from file to memory
    func loadSponsers(){
        
        let data = appData.getDataFromFile()
        
        if let sponsersData = data["sponsors"] as? [NSDictionary]{
            for sponserData in sponsersData{
                let sponser =  Sponser(dictionary: sponserData)
                self.sponsers.append(sponser)
            }
        }
    }
    
    // loads exhibitors from file to memory
    func loadExibitors(){
        
        let data = self.appData.getDataFromFile()
        if let exibitorsData = data["exhibitors"] as? [NSDictionary] {
            for exibitorData in exibitorsData{
                let exibitor = Exibitor(dictionary: exibitorData)
                exibitors.append(exibitor)
            }
        }
    }
    
    //loads speakes from file to memory
    func loadSpeakers(){
    
        let data = self.appData.getDataFromFile()
        if let speakersData = data["speakers"] as? [NSDictionary] {
            for speakerData in speakersData {
                let speaker = Speaker(dictionary: speakerData)
                speakers.append(speaker)
            }
        }
    }
    
    func getSponsers() -> [Sponser] {
        return self.sponsers
    }
    
    func getExibitors() -> [Exibitor] {
        return self.exibitors
    }
    
    func getSpeakers() -> [Speaker] {
        return self.speakers
    }
}