//
//  LaunchesData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 08/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct LaunchesData: Decodable{
    let flight_number:Int
    let mission_name : String
    let launch_date_local : String
    let launch_date_unix : TimeInterval
    let is_tentative : Bool
    let rocket : Rocket
    let launch_site: LaunchSite
    let details : String?
    let links : Links
    
    struct Rocket:Decodable {
        let rocket_id : String
        let rocket_name : String
        let second_stage : SecondStage
        
        struct SecondStage:Decodable {
            let payloads : [payload]
            
            struct payload:Decodable{
                let payload_id : String
                let reused : Bool
                let payload_type: String
            }
        }
    }
    struct LaunchSite:Decodable {
        let site_name: String?
        let site_name_long: String?
    }
    
    struct Links : Decodable {
        let mission_patch : URL?
        let flickr_images : [URL]?
    }
}

