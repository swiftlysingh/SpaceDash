//
//  NextLaunch.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 01/12/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NextLaunchData {
    
    let id : Int
    let date : String
    let name : String
    let providerName : String
    let providerSlug : String
    let vehicleId : Int
    let vehicleName : String
    let vehicleSlug : String
    let pad : PadData
    let missions : [String]
    let launchDesc : String
    let tags : [String]
    let weatherIcon : String
}

extension NextLaunchData : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case result
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let results = try container.decode([ResultData].self, forKey: .result)
        let result = results[0]

        id = result.id
        date = result.date
        name = result.name
        providerName = result.providerName
        providerSlug = result.providerSlug
        vehicleId = result.vehicleId
        vehicleName = result.vehicleName
        vehicleSlug = result.vehicleSlug
        pad = result.pad
        missions = result.missions
        launchDesc = result.launchDesc
        tags = result.tags
        weatherIcon = result.weatherIcon
    }
}
