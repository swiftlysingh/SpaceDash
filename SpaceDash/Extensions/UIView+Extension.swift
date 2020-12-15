//
//  UIView+Extension.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 15/12/2020.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

extension UIView {
    public static let defaultFadingAnimationDuration: TimeInterval = 1.0
    
    public func animate(isHidden: Bool, duration: TimeInterval = UIView.defaultFadingAnimationDuration, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            easeOut(duration: duration,
                    completion: completion)
        } else {
            easeIn(duration: duration,
                   completion: completion)
        }
    }
    public func easeOut(duration: TimeInterval = UIView.defaultFadingAnimationDuration, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut,
                       animations: {
                        self.alpha = 0.0
                       },
                       completion: { isFinished in
                        
                        self.isHidden = isFinished
                        
                        completion?(isFinished)
                       })
    }
    
    public func easeIn(duration: TimeInterval = UIView.defaultFadingAnimationDuration, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            // Make sure our animation is visible.
            isHidden = false
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn,
                       animations: {
                        self.alpha = 1.0
                       },
                       completion: completion)
    }
    
    func roundCorners(corners: UIRectCorner, radius: Int = 8) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    
}
