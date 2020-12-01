//
//  Result.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 01/12/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct Results {
    
    let id : Int
    let date : TimeInterval
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

extension Results : Decodable {
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case providerName
        case providerSlug
        case vehicleId
        case vehicleName
        case vehicleSlug
        case pad
        case missions
        case tags
        
        case date = "sort_date"
        case launchDesc = "launch_description"
        case weatherIcon = "weather_icon"
        
        enum ProviderKeys : String, CodingKey {
            case name
            case slug
        }
        
        enum VehicleKeys : String, CodingKey {
            case id
            case name
            case slug
        }
        
        enum TagKeys : String, CodingKey {
            case text
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        pad = try container.decode(PadData.self, forKey: .pad)
        missions = try container.decode([String].self, forKey: .missions)
        date = try container.decode(TimeInterval.self, forKey: .date)
        launchDesc = try container.decode(String.self, forKey: .launchDesc)
        weatherIcon = try container.decode(String.self, forKey: .weatherIcon)
        
        let providerKeys = try decoder.container(keyedBy: CodingKeys.ProviderKeys.self)
        providerName = try providerKeys.decode(String.self, forKey: .name)
        providerSlug = try providerKeys.decode(String.self, forKey: .slug)
        
        let vehicleKeys = try decoder.container(keyedBy: CodingKeys.VehicleKeys.self)
        vehicleId = try vehicleKeys.decode(Int.self, forKey: .id)
        vehicleName = try vehicleKeys.decode(String.self, forKey: .name)
        vehicleSlug = try vehicleKeys.decode(String.self, forKey: .slug)
        
        tags = try decoder.container(keyedBy: CodingKeys.TagKeys.self).decode([String].self, forKey: .text)
    }
}
