//
//  ApacheLog.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

struct ApacheLog {
    
    var threePageSequence: String
    var count: Int
    
    func printLog() {
        print("\(self.threePageSequence), \(self.count)")
    }
}
