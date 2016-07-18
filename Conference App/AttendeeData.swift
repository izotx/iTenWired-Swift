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

//  AttendeeData.swift
//  Conference App
//
//  Created by tuong on 4/13/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class AttendeeData {
    
    private let appData = AppData()
    
    /// List of Sponsers
    private var sponsers:[Sponsor] = []
    
    /// List of exhibitors
    private var exibitors:[Exhibitor] = []
    
    /// List of Spealkers
    private var speakers:[Speaker] = []

    
    init(){
        loadSponsers()
        loadExibitors()
        loadSpeakers()
    }
    
    // Loads sponsers from file to memory
    private func loadSponsers(){
        
        guard let data = appData.getDataFromFile() else {
            return
        }
        
        if let sponsersData = data["sponsors"] as? [NSDictionary]{
            for sponserData in sponsersData{
                let sponser =  Sponsor(dictionary: sponserData)
                self.sponsers.append(sponser)
            }
        }
    }
    
    // loads exhibitors from file to memory
    private func loadExibitors(){
        
        guard let data = self.appData.getDataFromFile() else{
            return
        }
        
        if let exibitorsData = data["exhibitors"] as? [NSDictionary] {
            for exibitorData in exibitorsData{
                let exibitor = Exhibitor(dictionary: exibitorData)
                exibitors.append(exibitor)
            }
        }
    }
    
    //loads speakes from file to memory
    private func loadSpeakers(){
    
        guard let data = self.appData.getDataFromFile() else {
            return
        }
        
        if let speakersData = data["speakers"] as? [NSDictionary] {
            for speakerData in speakersData {
                let speaker = Speaker(dictionary: speakerData)
                speakers.append(speaker)
            }
        }
    }
    
    func getSponsers() -> [Sponsor] {
        return self.sponsers
    }
    
    func getExibitors() -> [Exhibitor] {
        return self.exibitors
    }
    
    func getSpeakers() -> [Speaker] {
        return self.speakers
    }
}