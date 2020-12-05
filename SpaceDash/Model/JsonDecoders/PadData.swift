//
//  PadData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 01/12/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct PadData  {
    let name : String
    let location : String
//    let locationState : String?
//    let locationCountry : String
//    let locationSlug : String
}

extension PadData : Decodable {
    enum CodingKeys : String, CodingKey {
        case name
        case location
        case locationState
        case locationSlug
        
        enum LocationKeys : String, CodingKey {
            case name
            case state = "statename"
            case country
            case slug
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        let locationContainer = try decoder.container(keyedBy: CodingKeys.LocationKeys.self)
        location = try locationContainer.decode(String.self, forKey: .name)
//        locationState = try locationContainer.decode(String.self, forKey: .state)
//        locationCountry = try locationContainer.decode(String.self, forKey: .country)
//        locationSlug = try locationContainer.decode(String.self, forKey: .slug)
    }
}
