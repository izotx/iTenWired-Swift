//
//  Style.swift
//  Conference App
//
//  Created by Felipe on 5/19/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit


class ItenWiredStyle{

    static var shareButtonColor:UIColor!{
        get{
            return UIColor(red: 0.13, green: 0.33, blue: 0.57, alpha: 100)
        }
    }
    
    static var background:Background! {
    
        get{
            //Background
            let bg = Background()
            let bgColor = Color()
            
            // Background Color
            let bgMainColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
            bgColor.mainColor = bgMainColor
            
            let invertedColor = UIColor.whiteColor()
            bgColor.invertedColor = invertedColor
            
            bg.color = bgColor
            
            return bg
        }
    }
    
    static var text:Text! {
    
        get{
            //Text
            let tx = Text()
            
            //Text Color
            let txColor = Color()
            
            let txMainColor = UIColor.whiteColor()
            txColor.mainColor = txMainColor
            
            let txInvertedColor =  UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
            txColor.invertedColor = txInvertedColor
            
            tx.color = txColor
            
            return tx
        }
    }
}


internal class Background{
    var color:Color!
}

internal class Color{
    var mainColor:UIColor!
    var invertedColor:UIColor!
}

internal class Text{
    var color:Color!
}