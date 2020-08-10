//
//  LaunchPadsData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct LaunchPadData : Decodable{
    let id : Int
    let name : String
    let status : String
    let location : Location
    let vehicles_launched : [String]
    let attempted_launches : Int
    let successful_launches : Int
    let wikipedia : URL
    let details : String
    let site_name_long : String
    
    struct Location:Decodable {
        let name : String
        let region : String
    }
}
