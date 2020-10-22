//
//  UpcomingLaunchData.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 15/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

/// This struct will successfully decode the JSON file sent by SpaceX API
struct UpcomingLaunchData: Decodable{
    let mission_name : String
    let launch_date_local : String
    let launch_date_unix : TimeInterval
    let is_tentative : Bool
    let rocket : Rocket
    let launch_site: LaunchSite
    let links: Links

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
    
    struct Links:Decodable {
        let video_link: String?
        var video_link_url: URL? {
            guard let video_link = self.video_link else { return nil }
            guard let watch_url = URL(string: video_link) else { return nil }
            return watch_url
        }
    }
}



