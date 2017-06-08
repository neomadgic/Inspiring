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
                //If new user, set the userID to the current count then add page to the pagesArray
                userDictionary[user] = userDictionary.count
                let newUser = [page]
                pagesArray.append(newUser)
            }
        }
        
        parsedApacheLogArray = getParsedLogFrom(dictionary: pageSequenceDictionary)
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
    
    func getParsedLogFrom(dictionary: [String: Int]) -> [ApacheLog] {
        var apacheLogArray = [ApacheLog]()
        
        for (key,value) in dictionary {
            apacheLogArray.append(ApacheLog(threePageSequence: key, count: value))
        }
        
        return apacheLogArray
    }
}
