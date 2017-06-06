//
//  ApacheLog.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

struct ApacheLog {
    
    var user: String
    var page: String
    var count: Int
    
    func printLog() {
        print("\(self.user), \(self.page), \(self.count)")
    }
}
