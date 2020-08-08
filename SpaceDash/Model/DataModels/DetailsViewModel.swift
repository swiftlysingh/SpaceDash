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
    var capsules : [CapsulesData]?
    var ships : [ShipsData]?
    var launchPads : [LaunchPadData]?
    
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
        
        case Constants.SegueManager.SenderValues.capsules:
            if let data = capsules {
                count = data.count
                for capsule in data {
                    title.append("\(capsule.type) : \(capsule.capsule_serial)")
                    for mission in capsule.missions {
                        details.append(" \(capsule.details ?? "") \n \n Missions: \(mission.name) \n Original Launch: \(capsule.original_launch ?? Constants.DefaultArgs.noData)")
                    }
                }
            }
            break
            
        case Constants.SegueManager.SenderValues.ships:
            if let data = ships {
                count = data.count
                for ship in data {
                    title.append(ship.ship_name)
                    subTitle.append("Home Port: \(ship.home_port)")
                    details.append("Year Built: \(ship.year_built ?? 0) \n Type : \(ship.ship_type) \n Successful Landings: \(ship.successful_landings ?? 0)")
                    image.append((ship.image ?? URL(string: "https://i.imgur.com/28dCx6G.jpg"))!)
                }
            }
            break
        
        case Constants.SegueManager.SenderValues.launchSite:
            if let data = launchPads {
                count = data.count
                for ship in data {
                    title.append(ship.name)
                    subTitle.append("\(ship.site_name_long), \(ship.location.region)")
                    details.append(ship.details)
                }
            }
        default:
            return
        }
        
        title.remove(at: 0)
        subTitle.remove(at: 0)
        details.remove(at: 0)
        image.remove(at: 0)
    }
}
