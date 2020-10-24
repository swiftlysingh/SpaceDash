//
//  AppIconItem.swift
//  SpaceDash
//
//  Created by Raj Raval on 24/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct AppIcon {
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    static let items = [
        AppIcon(name: "Rocket", imageName: "SpaceDashIconRocket"),
        AppIcon(name: "Space Shuttle", imageName: "SpaceDashIconSpaceShuttle"),
        AppIcon(name: "Shuttle", imageName: "SpaceDashIconShuttle")
    ]
  
}
