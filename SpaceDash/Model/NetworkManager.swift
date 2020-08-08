//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 15/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func updateFromAPI( data: Any)
    func error( error: Error)
}

struct NetworkManager{
    
    var delegate:NetworkManagerDelegate?
    var key : String = " "
    
    
    /// This function will create the URL of the data demanded by any controllers
    /// - Parameter demand: the additional string that will be appended to the spaceXURL
    
    mutating func fetchData(demand: String){
        let urlString = "\(Constants.NetworkManager.baseURL)\(demand)"
        key = demand
        performRequest(urlString: urlString)
    }
    
    
    /// This will function will call the API and bring back the JSON data and will call parseJSON function to parse the data
    /// - Parameter urlString: URL created by fetchData
    
    func performRequest(urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(data: safeData)
                }
            }
            
            task.resume()
            
        }
    }
    
    /// This function will parse the JSON of the data it is sent
    /// - Parameter data: The data that need to be parsed
    
    func parseJSON(data: Data){
        let decoder = JSONDecoder()
        do{
            switch key {
            
            case Constants.NetworkManager.upcomingLaunchURL:
                var upcomingLaunch = UpcomingLaunchModel(decodedDataSet : try decoder.decode([UpcomingLaunchData].self, from: data))
                upcomingLaunch.cleanData()
                delegate?.updateFromAPI(data: upcomingLaunch)
                break
            
            case Constants.SegueManager.SenderValues.rocket:
                var rocket = DetailsViewModel(rockets: try decoder.decode([RocketData].self, from: data))
                rocket.fillData(key: Constants.SegueManager.SenderValues.rocket)
                delegate?.updateFromAPI(data: rocket)
                break
                
            case Constants.SegueManager.SenderValues.landpads:
                var landpads = DetailsViewModel(landpads: try decoder.decode([LandpadsData].self, from: data))
                landpads.fillData(key: Constants.SegueManager.SenderValues.landpads)
                delegate?.updateFromAPI(data: landpads)
                break
            
            case Constants.SegueManager.SenderValues.capsules:
                var capsules = DetailsViewModel(capsules:try decoder.decode([CapsulesData].self, from: data))
                capsules.fillData(key: Constants.SegueManager.SenderValues.capsules)
                delegate?.updateFromAPI(data: capsules)
                break
                
            case Constants.SegueManager.SenderValues.ships:
                var ships = DetailsViewModel(ships: try decoder.decode([ShipsData].self, from: data))
                ships.fillData(key: Constants.SegueManager.SenderValues.ships)
                delegate?.updateFromAPI(data: ships)
                break
                
            case Constants.SegueManager.SenderValues.launchSite:
                var launchPads = DetailsViewModel(launchPads: try decoder.decode([LaunchPadData].self, from: data))
                launchPads.fillData(key: Constants.SegueManager.SenderValues.launchSite)
                delegate?.updateFromAPI(data: launchPads)
                break
            default:
                return
            }
            
        } catch{
            delegate?.error(error: error)
        }
    }
}
