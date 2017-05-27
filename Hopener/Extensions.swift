//
//  Extensions.swift
//  Hopener
//
//  Created by Damian Nowakowski on 08/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    static func rgb(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}

extension UIView {
    
    enum GradientType {
        case horizontal
        case vertical
    }
    
    func applyGradient(colorStart:UIColor, colorCenter:UIColor, colorEnd:UIColor,type:GradientType = .horizontal, cornerRadius radius:CGFloat = 0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorStart.cgColor, colorCenter.cgColor, colorEnd.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        if(type == .horizontal) {
            gradientLayer.startPoint = CGPoint(x:0,y:0.5)
            gradientLayer.endPoint = CGPoint(x:1,y:0.5)
        }
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = radius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
