//
//  DetailsViewModel.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 07/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct DetailsViewModel {
    var rockets : [RocketData]?
    var landpads : [LandpadsData]?
    
    var title : [String] = [""]
    var subTitle : [String] = [""]
    var details : [String] = [""]
    var image : [URL] = [URL(string:Constants.NetworkManager.baseURL)!]
    var count : Int = 0
    
    mutating func fillData(key: String){
        
        switch key {
        case Constants.SegueManager.SenderValues.rocket:
            if let data = rockets {
                count = data.count
                for rocket in data {
                    title.append(rocket.rocket_name)
                    details.append(rocket.description)
                    let image_num = Int.random(in: 0..<rocket.flickr_images.count)
                    image.append(rocket.flickr_images[image_num])
                }
            }
            break
        
        case Constants.SegueManager.SenderValues.landpads:
            if let data = landpads {
                count = data.count
                for landpads in data {
                    title.append(landpads.full_name)
                    details.append(landpads.details)
                    subTitle.append("\(landpads.location.name), \(landpads.location.region)")
                }
            }
            break
            
        default:
            return
        }
        
        title.remove(at: 0)
        subTitle.remove(at: 0)
        details.remove(at: 0)
        image.remove(at: 0)
    }
}
