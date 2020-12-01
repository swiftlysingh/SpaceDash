//
//  NextLaunch.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 01/12/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NextLaunchData {
    
    let result : Results
}

extension NextLaunchData : Decodable {
    
    enum CodingKeys : String, CodingKey {
        case result
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let results = try container.decode([Results].self, forKey: .result)
        
        result = results[0]
    }
}
