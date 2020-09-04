//
//  LandpadsData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct LandpadsData : Decodable {
    let full_name : String
    let status : String
    let location : Location
    let wikipedia : URL
    let details : String
    
    struct Location : Decodable {
        let name : String
        let region : String
    }
}
