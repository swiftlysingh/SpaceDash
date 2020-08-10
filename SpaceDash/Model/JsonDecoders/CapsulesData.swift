//
//  capsules.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation


struct CapsulesData : Decodable {
    let capsule_serial : String
    let capsule_id : String
    let status : String
    let original_launch_unix : TimeInterval?
    let missions : [Missions]
    let details : String?
    let reuse_count : Int
    let landings : Int
    let type : String
    
    struct Missions:Decodable{
        let name : String
        let flight : Int
    }
}
