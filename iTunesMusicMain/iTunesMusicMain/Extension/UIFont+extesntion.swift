//
//  UIFont+extesntion.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit

extension UIFont {
    public static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Regular", size: size)!
    }
    
    public static func thin(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Thin", size: size)!
    }
    
    public static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Medium", size: size)!
    }
    
    public static func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Semibold", size: size)!
    }
    
    public static func light(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Light", size: size)!
    }
    
    public static func ultraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangTC-Ultralight", size: size)!
    }
}

