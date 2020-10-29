//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Pushpinder Pal Singh on 15/07/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NetworkManager{

    private let base : String
    
    init(_ base: String) {
        self.base = base
    }
    
    /// This will function will call the API and bring back the JSON data and will call parseJSON function to parse the data
    func performRequest<T: Decodable>(key: String, completion: @escaping (Result<T,Error>) -> Void){
        
        if let url = URL(string: "\(base)\(key)"){
            
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
