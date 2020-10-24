//
//  UpcomingLaunchModel.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 17/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct UpcomingLaunchModel{
    var decodedDataSet : [UpcomingLaunchData]
    var decodedData: UpcomingLaunchData?
    
    /// Will return the first Launch if no future launch is found
    mutating func cleanData(){
        for data in decodedDataSet {
                if data.launch_date_unix>=NSDate().timeIntervalSince1970 {
                    decodedData = data
                    return
                }
            }
        decodedData = decodedDataSet[0]
    }
}
