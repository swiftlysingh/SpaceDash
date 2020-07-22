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
    
    mutating func cleanData(){
        for data in decodedDataSet {
            if !data.is_tentative{
                print(data.is_tentative)
                decodedData = data
                break
            }
        }
//        decodedData = decodedDataSet[0]
    }
}
