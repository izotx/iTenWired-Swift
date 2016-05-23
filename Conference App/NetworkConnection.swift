//
//  NetworkConnection.swift
//  Conference App
//
//  Created by Felipe on 5/23/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation

class NetworkConnection{
    
    static func isConnected() -> Bool {
        let reach = Reach()
        return !(reach.connectionStatus().description == "Offline")
    }
}