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
    
    func printLog() {
        print("\(self.user), \(self.page)")
    }
}

extension ApacheLog: Equatable {}

func ==(lhs: ApacheLog, rhs: ApacheLog) -> Bool {
    let areEqual = lhs.user == rhs.user &&
        lhs.page == rhs.page
    
    return areEqual
}
