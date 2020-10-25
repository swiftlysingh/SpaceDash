//
//  UpcomingView.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 27/06/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class UpcomingView: UIView {
    
    var heightAnchorNormal: NSLayoutConstraint?
    var heightAnchorSmall: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        heightAnchorNormal = self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.55)
        heightAnchorSmall = self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.65)
        configUpcomingLaunchPanel()
    }
    
    /// Adding Curves to Upcoming Launch Panel
    func configUpcomingLaunchPanel(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        heightAnchorNormal?.isActive = true
        self.layer.cornerRadius = CGFloat(35)
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    func setupSmallHeight() {
        heightAnchorNormal?.isActive = false
        heightAnchorSmall?.isActive = true
    }
    
}
