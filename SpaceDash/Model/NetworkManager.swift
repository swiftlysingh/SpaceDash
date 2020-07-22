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
    let spaceXURL = "https://api.spacexdata.com/v3/"

    
/// This function will create the URL of the data demanded by any controllers
/// - Parameter demand: the additional string that will be appended to the spaceXURL
    
     func fetchData(key: String){
        let urlString = "\(spaceXURL)\(key)"
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
            var upcomingLaunch = UpcomingLaunchModel(decodedDataSet : try decoder.decode([UpcomingLaunchData].self, from: data))
            upcomingLaunch.cleanData()
            delegate?.updateFromAPI(data: upcomingLaunch)
            
        } catch{
            print(error)
        }
    }
}
