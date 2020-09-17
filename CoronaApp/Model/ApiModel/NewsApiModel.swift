//
//  NewsApiModel.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/27.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation


struct News: Codable {
    
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NewsItem]
    
}


struct NewsItem: Codable {
    
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String
    
}
