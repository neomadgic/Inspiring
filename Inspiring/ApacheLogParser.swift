//
//  ApacheLogParser.swift
//  Inspiring
//
//  Created by Vu Dang on 6/7/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class ApacheLogParser {

    func parse(apacheLog: String) -> [ApacheLog] {

        var parsedApacheLogArray = [ApacheLog]()
        var userDictionary = [String: Int]()
        var pageSequenceDictionary = [String:Int]()
        var pagesArray = [[String]]()
        
        //Separate each log into an array
        let apacheLogArray = apacheLog.components(separatedBy: "\n")
        
        for x in 0...apacheLogArray.count - 2 {
            
            //Grab user and page from the log
            let user = apacheLogArray[x].components(separatedBy: " ")[0]
            let page = apacheLogArray[x].components(separatedBy: " ")[6]
            
            if let userID = userDictionary[user] {
                pagesArray[userID].append(page)
                
                //If there are 3 pages in the array, add the sequence to the dictionary
                if pagesArray[userID].count >= 3 {
                    let pageSequence = getThreePageSequence(fromArray: pagesArray, using: userID)
                    pageSequenceDictionary[pageSequence] = updateDictionary(count: pageSequenceDictionary[pageSequence])
                }
                
            } else {
                userDictionary[user] = userDictionary.count
                let newUser = [page]
                pagesArray.append(newUser)
            }
        }
        
        for (key,value) in pageSequenceDictionary {
            parsedApacheLogArray.append(ApacheLog(threePageSequence: key, count: value))
        }

        parsedApacheLogArray.sort { (apacheLog1, apacheLog2) -> Bool in
            return apacheLog1.count > apacheLog2.count
        }
        
        return parsedApacheLogArray
    }
    
    func updateDictionary(count: Int?) -> Int {
        if count != nil {
            return count! + 1
        } else {
            return 1
        }
    }
    
    func getThreePageSequence(fromArray: [[String]], using: Int) -> String{
        let sizeOfArray = fromArray[using].count
        return "\(fromArray[using][sizeOfArray-3]), \(fromArray[using][sizeOfArray-2]), \(fromArray[using][sizeOfArray-1])"
    }
    
    
    
    
//    func parse(apacheLog: String) -> [ApacheLog] {
//
//        var currentStreakDictionary = [String: [String: [String:Any]]]()
//        var threePageSequenceDictionary = [String:Int]()
//        var parsedApacheLogArray = [ApacheLog]()
//        
//        //Separate each log into an array
//        let apacheLogArray = apacheLog.components(separatedBy: "\n")
//        
//        for x in 0...apacheLogArray.count - 2 {
//            
//            //Grab user and page from the log
//            let user = apacheLogArray[x].components(separatedBy: " ")[0]
//            let page = apacheLogArray[x].components(separatedBy: " ")[6]
//            
//            if isPageEqual(newPage: page, oldPage: currentStreakDictionary[user]?["currentStreak"]?["name"] as? String) {
//                
//                //Add to the current streak count of that specific user and page
//                let newStreakCount = (currentStreakDictionary[user]?["currentStreak"]?["count"] as? Int)! + 1
//                currentStreakDictionary[user] = updateCurrentStreak(page: page, count: newStreakCount)
//                
//                //Add apacheLog to the dictionary if streak is greater than 3
//                if newStreakCount >= 3 {
//                    threePageSequenceDictionary["\(user) \(page)"] = updateThreePageSequence(count: threePageSequenceDictionary["\(user) \(page)"])
//                }
//            } else {
//                currentStreakDictionary[user] = updateCurrentStreak(page: page, count: 1)
//            }
//        }
//        
//        for (key,value) in threePageSequenceDictionary {
//            let user = key.components(separatedBy: " ")[0]
//            let page = key.components(separatedBy: " ")[1]
//            let count = value
//            parsedApacheLogArray.append(ApacheLog(user: user, page: page, count: count))
//        }
//        
//        parsedApacheLogArray.sort { (apacheLog1, apacheLog2) -> Bool in
//            return apacheLog1.count > apacheLog2.count
//        }
//        
//        return parsedApacheLogArray
//
//    }
//
//
//    func isPageEqual(newPage: String, oldPage: String?) -> Bool {
//        if newPage == oldPage {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func updateCurrentStreak(page: String, count: Int) -> [String: [String:Any]] {
//        
//        return ["currentStreak" : ["name": page, "count": count]]
//    }
}
