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
    var launches : [LaunchesData]?
    
    var title : [String] = [""]
    var subTitle : [String] = [""]
    var details : [String] = [""]
    var image : [URL] = [URL(string:Constants.NetworkManager.baseURL)!]
    var count : Int = 0
    var isActive : [Bool] = [false]
    
    /// This function will fill in all the important data to data variables.
    mutating func fillData(key: String){
        
        switch key {
        case Constants.SegueManager.SenderValues.rocket:
            if var data = rockets {
                count = data.count
                data.sort(by: { $0.id > $1.id})
                for rocket in data {
                    title.append(rocket.rocket_name)
                    details.append(rocket.description)
                    let image_num = Int.random(in: 0..<rocket.flickr_images.count)
                    image.append(rocket.flickr_images[image_num])
                    isActive.append(rocket.active)
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
                    isActive.append((landpads.status=="active"))
                }
            }
            break
            
        case Constants.SegueManager.SenderValues.capsules:
            if var data = capsules {
                count = data.count
                data.sort(by: { $0.capsule_serial > $1.capsule_serial  })
                for capsule in data {
                    title.append("\(capsule.type) : \(capsule.capsule_serial)")
                    for mission in capsule.missions {
                        details.append("\(capsule.details ?? "") \n \nMissions: \(mission.name) \n Original Launch: \(getDate(capsule.original_launch_unix) )")
                    }
                    isActive.append(false)
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
                    isActive.append(ship.active)
                }
            }
            break
            
        case Constants.SegueManager.SenderValues.launchSite:
            if var data = launchPads {
                count = data.count
                data.sort(by: {$0.id > $1.id})
                for ship in data {
                    title.append(ship.name)
                    subTitle.append("\(ship.site_name_long), \(ship.location.region)")
                    details.append(ship.details)
                    isActive.append(ship.status=="active")
                }
            }
            break
            
        case Constants.SegueManager.SenderValues.launches:
            if var data = launches{
                count = data.count
                data.sort(by: { $0.launch_date_unix > $1.launch_date_unix  })
                
                for launch in data {
                    title.append(launch.mission_name)
                    details.append(launch.details ?? Constants.DefaultArgs.noData)
                    subTitle.append(getDate(launch.launch_date_unix))
                    isActive.append(false)
                }
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
    
    func getDate(_ time: TimeInterval?)-> String{
        if let timeInUnix = time{
            let date = Date(timeIntervalSince1970: timeInUnix)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
            return Constants.DefaultArgs.noData
    }
}
