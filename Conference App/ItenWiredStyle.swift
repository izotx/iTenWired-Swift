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
            return UIColor(hexString: "#099acc")//UIColor(red: 0.13, green: 0.33, blue: 0.57, alpha: 100)
        }
    }
    
    static var background:Background! {
    
        get{
            //Background
            let bg = Background()
            let bgColor = Color()
            
            // Background Color - hex: #265a99
            let bgMainColor = UIColor(red: 0.15, green: 0.353, blue: 0.6, alpha: 100)
             bgColor.mainColor = UIColor(hexString: "#14b1e7")
            //bgColor.mainColor = bgMainColor
            
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
            txColor.invertedColor = UIColor(hexString: "#14b1e7")//txInvertedColor
            
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



extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = NSScanner(string: hexString as String)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return NSString(format:"#%06x", rgb) as String
    }
}