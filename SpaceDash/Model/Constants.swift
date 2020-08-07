//
//  Constants.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 26/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Networking {
        static let baseURL = "https://api.spacexdata.com/v3/"
        static let upcomingLaunchURL = "launches/Upcoming"
        
    }
    
    struct defaultArgs {
        static let launchSite = "Launch Site Not Declared"
        static let noData = "Not Available"
    }
    
    struct HomeView{
        let upcomingLaunch: UpcomingLaunchModel
        
        lazy var payloadAndType = "\(upcomingLaunch.decodedData?.rocket.second_stage.payloads[0].payload_id ?? Constants.defaultArgs.noData ), \(upcomingLaunch.decodedData?.rocket.second_stage.payloads[0].payload_type ?? Constants.defaultArgs.noData)"
        
        lazy var launchSite = self.upcomingLaunch.decodedData?.launch_site.site_name_long ?? Constants.defaultArgs.launchSite
        
        lazy var rocket = upcomingLaunch.decodedData?.rocket.rocket_name ?? "Falcon 9"
    }
    
    struct segueManager {
        static let detailViewSegue = "DetailView"
        
        struct senderValues {
            static let rocket = "rocket"
            static let launchSite = "launchSite"
            static let landpads = "landpads"
            static let capsules = "capsules"
            static let ships = "ships"
            static let launches = "launches"
        }
    }
}
