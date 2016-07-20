//    Copyright (c) 2016, Izotx
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
//    * Neither the name of Izotx nor the names of its contributors may be used to
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
//  ImageDownloader.swift
//  Conference App
//
//  Created by Felipe on 5/12/16.


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