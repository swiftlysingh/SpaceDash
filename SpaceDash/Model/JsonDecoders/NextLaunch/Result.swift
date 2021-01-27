//
//  Result.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 01/12/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct ResultData {
    
    let id : Int
    let date : String
    let name : String
    let providerName : String
    let providerSlug : String
    let vehicleId : Int
    let vehicleName : String
    let vehicleSlug : String
    let pad : PadData
    let missions : String
    let launchDesc : String
    let tags : [String]
    let weatherIconCode : String?
    let mediaId : Int?
    let youtubeLink : URL?
    let launchDayMedia : Bool?
    let featured : Bool?
}

extension ResultData : Decodable {
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
        
        case provider
        case vehicle
        
        case media
        case mediaId
        case youtubeLink
        case launchDayMedia
        case featured
        
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
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        pad = try container.decode(PadData.self, forKey: .pad)
        date = try container.decode(String.self, forKey: .date)
        launchDesc = try container.decode(String.self, forKey: .launchDesc)
        weatherIconCode = try container.decode(String?.self, forKey: .weatherIcon)

        let providerKeys = try container.nestedContainer(keyedBy: CodingKeys.ProviderKeys.self, forKey: .provider)
        providerName = try providerKeys.decode(String.self, forKey: .name)
        providerSlug = try providerKeys.decode(String.self, forKey: .slug)

        let vehicleKeys = try container.nestedContainer(keyedBy: CodingKeys.VehicleKeys.self, forKey: .vehicle)
        vehicleId = try vehicleKeys.decode(Int.self, forKey: .id)
        vehicleName = try vehicleKeys.decode(String.self, forKey: .name)
        vehicleSlug = try vehicleKeys.decode(String.self, forKey: .slug)

        let missionData = try container.decode([MissionData].self, forKey: .missions)
        var missionString = String()
        
        if missionData.count > 1 {
            for mission in missionData {
                missionString = missionString + ", " + mission.name
            }
            missions = missionString
        }
        else {
            missions = missionData[0].name
        }
                
        let tagData = try container.decode([TagsData].self, forKey: .tags)
        var tag = [String]()

        for tags in tagData {
            tag.append(tags.text)
        }

        tags = tag
        
        if let mediaData = try container.decode([MediaData]?.self, forKey: .media){
            mediaId = mediaData[0].id
            featured = mediaData[0].featured
            launchDayMedia = mediaData[0].ldfeatured
            youtubeLink = URL(string:"\(Constants.NetworkManager.youtubeWatchURL + mediaData[0].youtube_vidid)")
        } else{
            mediaId = nil
            featured = nil
            launchDayMedia = nil
            youtubeLink = nil
        }
    }
}
