//
//  RocketsData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 07/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct RocketData: Decodable {
    let id : Int
    let active : Bool
    let rocket_name : String
    let rocket_type : String
    let description : String
    let wikipedia : String
    
    let flickr_images : [URL]
    
}


