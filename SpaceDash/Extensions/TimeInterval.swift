//
//  TimeInterval.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 25/10/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation


extension TimeInterval {
    
    func getDate() -> String{
        
        let date = Date(timeIntervalSince1970: self )
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
