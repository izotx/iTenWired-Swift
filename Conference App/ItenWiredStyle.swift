//
//  Style.swift
//  Conference App
//
//  Created by Felipe on 5/19/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit


class ItenWiredStyle{

    static var background:Background! {
    
        get{
            //Background
            let bg = Background()
            
            // Background Color
            let bgMainColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
            
            let bgColor = Color()
            bgColor.mainColor = bgMainColor
            
            bg.color = bgColor
            
            return bg
        }
    }
}


internal class Background{
    var color:Color!
}

internal class Color{
    var mainColor:UIColor!
    var secondaryColor:UIColor!
}