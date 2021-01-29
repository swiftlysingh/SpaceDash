//
//  NewsViewModel.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 27/01/2021.
//  Copyright © 2021 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

class NewsViewModel{
    
    typealias didFetchNewDataCompeleted = (Result<NewsData, Error>) -> Void
    
    var didFetchNewData: didFetchNewDataCompeleted?
    
    init() {
        NetworkManager.shared.fetchData(demand: Constants.SegueManager.SenderValues.news)
    }
}
