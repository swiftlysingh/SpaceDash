//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 15/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NetworkManager{
    let spaceXURL = "https://api.spacexdata.com/v3/"
    
    func fetchData(demand: String){
        let urlString = "\(spaceXURL)\(demand)"
        performRequest(urlString: urlString)
    }
    
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
    func parseJSON(data: Data){
        let decoder = JSONDecoder()
        let upcomingLaunches = [UpcomingLaunchData].self
        do{
            let decodedData = try decoder.decode(upcomingLaunches.self, from: data)
        } catch{
            print(error)
        }
    }
}
