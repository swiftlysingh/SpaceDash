//
//  NewsData.swift
//  SpaceDash
//
//  Created by akhigbe benjamin on 27/01/2021.
//  Copyright © 2021 Pushpinder Pal Singh. All rights reserved.
//

import Foundation

struct NewsDatum: Codable {
    let id, title: String
    let url: String
    let imageURL: String
    let newsSite, summary, publishedAt, updatedAt: String
    let featured: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, url
        case imageURL = "imageUrl"
        case newsSite, summary, publishedAt, updatedAt, featured
    }
}

typealias NewsData = [NewsDatum]
