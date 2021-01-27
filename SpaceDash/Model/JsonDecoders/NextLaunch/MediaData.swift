//
//  MediaData.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 27/01/21.
//  Copyright © 2021 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct MediaData : Decodable {
    let id : Int
    let youtube_vidid  : String
    let featured : Bool
    let ldfeatured : Bool
    let approved : Bool
}
