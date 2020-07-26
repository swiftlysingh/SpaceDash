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
                if data.launch_date_unix>=NSDate().timeIntervalSince1970 {
                    decodedData = data
                    return
                }
            }
        decodedData = decodedDataSet[0]
    }
    
    func getDate()-> String{
        if let timeResult = (decodedData?.launch_date_unix){
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return "TBD"
    }
}
