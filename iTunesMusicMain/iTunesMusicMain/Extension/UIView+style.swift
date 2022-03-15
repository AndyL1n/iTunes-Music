//
//  UIView+style.swift
//  iTunesMusicMain
//
//  Created by Andy on 2022/3/15.
//

import UIKit

extension UIView {
    
    public func makeRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }

    public func makeRadiusForEachCorner(radius: CGFloat, corners: CACornerMask?) {
        self.layer.cornerRadius = radius
        
        if let corners = corners {
            self.layer.maskedCorners = corners
        }
    }
    
    public func addShadow(width: CGFloat = 0.2, height: CGFloat = 0.2, color: UIColor, opacity: Float = 0.5, radius: CGFloat = 0.5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }

}
