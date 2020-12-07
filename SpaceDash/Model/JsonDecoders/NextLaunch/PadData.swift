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
    let locationSlug : String
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
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.LocationKeys.self, forKey: .location)
        
        locationSlug = try locationContainer.decode(String.self, forKey: .slug)
        
        let city = try locationContainer.decode(String.self, forKey: .name)
        
        let locationCountry = try locationContainer.decode(String.self, forKey: .country)
        
        var stateString = ""
        
        if let state = try locationContainer.decode(String?.self, forKey: .state){
            stateString = "\(state),"
        }
        
        location = "\(city), \(stateString) \(locationCountry)"
    }
}
