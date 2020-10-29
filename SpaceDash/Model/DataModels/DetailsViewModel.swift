//
//  DetailsViewModel.swift
//  SpaceDash
//
//  Created by Pushpinder Pal Singh on 07/08/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    var title : [String] = [""]
    var subTitle : [String] = [""]
    var details : [String] = [""]
    var image : [URL] = [URL(string:Constants.NetworkManager.baseURL)!]
    var count : Int = 0
    var isActive : [Bool] = [false]
    
    /// This function will fill in all the important data to data variables.
    func fillData<T:Decodable>(model: T,key: String){
        
        switch key {
        case Constants.SegueManager.SenderValues.rocket:
            var data = model as! [RocketData]
            count = data.count
            data.sort(by: { $0.id > $1.id})
            for rocket in data {
                title.append(rocket.rocket_name)
                details.append(rocket.description)
                let image_num = Int.random(in: 0..<rocket.flickr_images.count)
                image.append(rocket.flickr_images[image_num])
                isActive.append(rocket.active)
            }
            break
            
        case Constants.SegueManager.SenderValues.landpads:
            let data = model as! [LandpadsData]
            count = data.count
            for landpads in data {
                title.append(landpads.full_name)
                details.append(landpads.details)
                subTitle.append("\(landpads.location.name), \(landpads.location.region)")
                isActive.append((landpads.status=="active"))
            }
            break
            
        case Constants.SegueManager.SenderValues.capsules:
            var data = model as! [CapsulesData]
            count = data.count
            data.sort(by: { $0.capsule_serial > $1.capsule_serial  })
            for capsule in data {
                title.append("\(capsule.type) : \(capsule.capsule_serial)")
                for mission in capsule.missions {
                    details.append("\(capsule.details ?? "") \n \nMissions: \(mission.name) \n Original Launch: \(capsule.original_launch_unix?.getDate() ?? "" )")
                }
                isActive.append(false)
            }
            break
            
        case Constants.SegueManager.SenderValues.ships:
            let data = model as! [ShipsData]
            count = data.count
            for ship in data {
                title.append(ship.ship_name)
                subTitle.append("Home Port: \(ship.home_port)")
                details.append("Year Built: \(ship.year_built ?? 0) \n Type : \(ship.ship_type) \n Successful Landings: \(ship.successful_landings ?? 0)")
                image.append((ship.image ?? URL(string: "https://i.imgur.com/28dCx6G.jpg"))!)
                isActive.append(ship.active)
            }
            break
            
        case Constants.SegueManager.SenderValues.launchSite:
            var data = model as! [LaunchPadData]
            count = data.count
            data.sort(by: {$0.id > $1.id})
            for ship in data {
                title.append(ship.name)
                subTitle.append("\(ship.site_name_long), \(ship.location.region)")
                details.append(ship.details)
                isActive.append(ship.status=="active")
            }
            break
            
        case Constants.SegueManager.SenderValues.launches:
            var data = model as! [LaunchesData]
            count = data.count
            data.sort(by: { $0.launch_date_unix > $1.launch_date_unix  })
            
            for launch in data {
                title.append(launch.mission_name)
                details.append(launch.details ?? Constants.DefaultArgs.noData)
                subTitle.append(launch.launch_date_unix.getDate())
                isActive.append(false)
            }
        default:
            return
        }
        
        isActive.remove(at: 0)
        title.remove(at: 0)
        subTitle.remove(at: 0)
        details.remove(at: 0)
        image.remove(at: 0)
    }
}
