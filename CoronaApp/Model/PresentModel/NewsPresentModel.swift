//
//  NewsPresentModel.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/27.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation

struct NewsPresentModel {
    
    private let dto: NewsItem
    
    let title: String
    let description: String
    let originLink: String
    
    
    init(_ _dto: NewsItem) {
        dto = _dto
        
        title = _dto.title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "&quot;", with: "")
        description = _dto.description.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "&quot;", with: "")
        originLink = _dto.originallink
    }
    
}
