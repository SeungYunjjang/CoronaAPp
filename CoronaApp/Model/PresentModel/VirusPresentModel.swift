//
//  VirusPresentModel.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/25.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation

struct VirusPresentModel {
    
    private let dto: Virus
    
    let title: String
    let lattitude: Double
    let longtitude: Double
    let content: String
    
    init(_ _dto: Virus) {
        
        dto = _dto
        title = _dto.title
        
        let location = _dto.latlng.components(separatedBy: ",")
        
        lattitude = Double(location[0])!
        longtitude = Double(location[1])!
            
        content = _dto.content
        
    }
    
}
