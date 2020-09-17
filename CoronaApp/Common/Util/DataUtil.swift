//
//  DataUtil.swift
//  CoronaApp
//
//  Created by andrew on 2020/02/26.
//  Copyright © 2020 Yunjjang. All rights reserved.
//

import Foundation

class DataUtil {
    
    private init() {}
    
    class var currentTime: UInt64 { // micro seconds
        return UInt64(NSDate().timeIntervalSince1970 * 1000)
    }
}

