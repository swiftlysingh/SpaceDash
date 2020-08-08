//
//  ShipsData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct ShipsData : Decodable {
    
    let ship_name : String
    let ship_type : String
    let roles : [String]
    let active : Bool
    let home_port : String
    let year_built : Int?
    let successful_landings : Int?
    let attempted_landings : Int?
    let image : URL?
}
