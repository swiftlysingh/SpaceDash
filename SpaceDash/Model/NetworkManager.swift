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
    
    func performRequest<T: Decodable>(completion: @escaping (Result<T,Error>) -> Void){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(error!))
                }
                
                if let safeData = data {
                    
                    let decoder = JSONDecoder()
                    
                    do{
                        completion(.success(try decoder.decode(T.self, from: safeData)))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
            
        }
        return
    }
}
