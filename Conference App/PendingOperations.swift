//
//  PendingOperations.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import Foundation


class PendingOperarions {

    lazy var downloadsInProgress = [Int:NSOperation]()
    lazy var downloadQueue:NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Download queue"
        return queue
    }()
}
