//
//  CALayer.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 27/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

extension CALayer {
    
    /// Function to add Shadow
    /// - Parameters:
    ///   - color: The Colour of the Shadow
    ///   - alpha: Transparency Value
    ///   - x: X axis of shadow
    ///   - y: y axis of shadow
    ///   - blur: blur of the shadow
    ///   - spread: spread of the shadow
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
