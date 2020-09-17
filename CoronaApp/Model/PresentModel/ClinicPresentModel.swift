//
//  ClinicPresentModel.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/25.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation

struct ClinicPresentModel {
    
    private let dto: Clinic
    
    let clinicName: String
    let lattitude: Double
    let longtitude: Double
    let address: String
    let phoneNumber: String
    
    init(_ _dto: Clinic) {
        
        dto = _dto
        clinicName = _dto.clinicName
        lattitude = Double(_dto.lattitude)!
        longtitude = Double(_dto.longtitude)!
        address = _dto.roadaddr
        phoneNumber = _dto.phone
    
    }
    
}
