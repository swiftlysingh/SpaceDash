//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 15/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NetworkManager{
    
    weak var delegate:NetworkManagerDelegate?
    private let key : String
    private let urlString : String
    
    init(key: String) {
        self.key = key
        self.urlString = "\(Constants.NetworkManager.baseURL)\(key)"
    }
    
    /// This will function will call the API and bring back the JSON data and will call parseJSON function to parse the data
    
    func performRequest(){
        
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
        let detailModel = DetailsViewModel()
        
        do{
            switch key {
            
            case Constants.NetworkManager.upcomingLaunchURL:
                var upcomingLaunch = UpcomingLaunchModel(decodedDataSet : try decoder.decode([UpcomingLaunchData].self, from: data))
                upcomingLaunch.cleanData()
                delegate?.updateFromAPI(data: upcomingLaunch)
                break
            
            case Constants.SegueManager.SenderValues.rocket:
                detailModel.rockets = try decoder.decode([RocketData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.rocket)
                delegate?.updateFromAPI(data: detailModel)
                break
                
            case Constants.SegueManager.SenderValues.landpads:
                detailModel.landpads = try decoder.decode([LandpadsData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.landpads)
                delegate?.updateFromAPI(data: detailModel)
                break
            
            case Constants.SegueManager.SenderValues.capsules:
                detailModel.capsules = try decoder.decode([CapsulesData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.capsules)
                delegate?.updateFromAPI(data: detailModel)
                break
                
            case Constants.SegueManager.SenderValues.ships:
                detailModel.ships =  try decoder.decode([ShipsData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.ships)
                delegate?.updateFromAPI(data: detailModel)
                break
                
            case Constants.SegueManager.SenderValues.launchSite:
                detailModel.launchPads = try decoder.decode([LaunchPadData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.launchSite)
                delegate?.updateFromAPI(data: detailModel)
                break
                
            case Constants.SegueManager.SenderValues.launches:
                detailModel.launches = try decoder.decode([LaunchesData].self, from: data)
                detailModel.fillData(key: Constants.SegueManager.SenderValues.launches)
                delegate?.updateFromAPI(data: detailModel)
            default:
                return
            }
            
        } catch{
            delegate?.error(error: error)
        }
    }
}
