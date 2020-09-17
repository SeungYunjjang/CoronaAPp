//
//  Clinic.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/25.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation

struct Clinic: Codable {
    
    let clinicName: String
    let lattitude: String
    let longtitude: String
    let phone: String
    let roadaddr: String
    
}

struct Virus: Codable {
    
    let title: String
    let latlng: String
    let content: String
    
}
