//
//  UpcomingLaunchModel.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 17/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

class UpcomingLaunchModel{
    
    var launchSite : String?
    var payloadAndType : String?
    var launchDate : String?
    var isTentative : Bool?
    var rocket : String?
    var watchNow : URL?
    
    /// Will return the first Launch if no future launch is found
    func cleanData(_ launch: [UpcomingLaunchData]) -> UpcomingLaunchData{
        for data in launch {
                if data.launch_date_unix>=NSDate().timeIntervalSince1970 {
                    return data
                }
            }
        return launch[0]
    }
}
