//
//  ImageDownloader.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class ImageDownloader : NSOperation{

    let photoRecord: Photorecord
    let reach = Reach()
    
    init(photoRecord : Photorecord){
        self.photoRecord = photoRecord
    }
    
    override func main() {
    
        if self.cancelled {
            return
        }
        
        let flag = !NetworkConnection.isConnected()
        
        if  flag {
            self.photoRecord.state = PhotoRecordState.Failed
            return
        }
        let imageData = NSData(contentsOfURL: self.photoRecord.url)
        
        if self.cancelled {
            return
        }
    
        if imageData?.length > 0{
            self.photoRecord.image = UIImage(data: imageData!)
            self.photoRecord.state = PhotoRecordState.Downloaded
        }else {
            self.photoRecord.state = PhotoRecordState.Failed
            self.photoRecord.image = UIImage(named: "Failed")
        }
    }
}