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
    let isAuth : Bool
    let date : String
    let name : String
    let providerName : String
    let providerSlug : String
    let vehicleId : Int
    let vehicleName : String
    let vehicleSlug : String
    let launchSite : String
    let countrySlug : String
    let missions : String
    let launchDesc : String
    let tags : [String]
    let weatherIcon : String?
}

extension NextLaunchData : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case result
        case isAuth = "valid_auth"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let results = try container.decode([ResultData].self, forKey: .result)
        let result = results[0]
        
        isAuth = try container.decode(Bool.self, forKey: .isAuth)

// Following is copying data decoded from result into the current object. If you have a better way to do this, let me know
        
        id = result.id
        date = Double(result.date)?.getDate() ?? Constants.DefaultArgs.noData
        name = result.name
        providerName = result.providerName
        providerSlug = result.providerSlug
        vehicleId = result.vehicleId
        vehicleName = result.vehicleName
        vehicleSlug = result.vehicleSlug
        launchSite = result.pad.location
        countrySlug = result.pad.countrySlug
        missions = result.missions
        launchDesc = result.launchDesc
        tags = result.tags
        weatherIcon = result.weatherIcon
    }
}
