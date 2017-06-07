//
//  NetworkService.swift
//  Inspiring
//
//  Created by Vu Dang on 6/6/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import Foundation

class NetworkService {
    
    static var instance = NetworkService()
    
    func downloadApacheLog(withURL: String, completion : @escaping (_ apacheLogAsString: String, _ error : NSError?) -> Void) {
    
        var downloadedString = ""
        
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: withURL)
            
            do {
                let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                downloadedString = urlContents
            } catch let error as NSError{
                print(error)
                completion("", error)
            }
            
            DispatchQueue.main.async {
            
                completion(downloadedString, nil)
            }
        }
    }
    
    func returnParsedApacheLog(withURL: String, completion: @escaping (_ parsedApacheLog: [ApacheLog], _ error: NSError?) -> Void) {
        
        var parsedApacheLogArray = [ApacheLog]()
        
        //Move into background thread
        DispatchQueue.global(qos: .background).async {
            
            let url = URL(string: withURL)
            do {
                
                //Download content
                let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                parsedApacheLogArray = self.parse(apacheLog: urlContents)
                
            } catch let error as NSError{
                print(error)
                completion(parsedApacheLogArray, error)
            }
            
            DispatchQueue.main.async {
                completion(parsedApacheLogArray, nil)
            }

        }
    }
    
    func parse(apacheLog: String) -> [ApacheLog] {
        
        var currentStreakDictionary = [String: [String: [String:Any]]]()
        var threePageSequenceDictionary = [String:Int]()
        var parsedApacheLogArray = [ApacheLog]()
        
        //Separate each log into an array
        let apacheLogArray = apacheLog.components(separatedBy: "\n")
        
        for x in 0...apacheLogArray.count - 2 {
            
            //Grab user and page from the log
            let user = apacheLogArray[x].components(separatedBy: " ")[0]
            let page = apacheLogArray[x].components(separatedBy: " ")[6]
            
            //Check if page is the same as the last page from the user
//            if let oldPage = currentStreakDictionary[user]?["currentStreak"]?["name"] as? String {
//                if isPageEqual(newPage: page, oldPage: oldPage) {
//                    
//                    //Add to the current streak count of that specific user and page
//                    let newStreakCount = (currentStreakDictionary[user]?["currentStreak"]?["count"] as? Int)! + 1
//                    currentStreakDictionary[user] = updateCurrentStreak(page: page, count: newStreakCount)
//                    
//                    //Add apacheLog to the dictionary if streak is greater than 3
//                    if newStreakCount >= 3 {
//                        threePageSequenceDictionary["\(user) \(page)"] = updateThreePageSequence(count: threePageSequenceDictionary["\(user) \(page)"])
//                    }
//                } else {
//                    currentStreakDictionary[user] = updateCurrentStreak(page: page, count: 1)
//                }
//            } else {
//                currentStreakDictionary[user] = updateCurrentStreak(page: page, count: 1)
//            }
            
            if isPageEqual(newPage: page, oldPage: currentStreakDictionary[user]?["currentStreak"]?["name"] as? String) {
                
                //Add to the current streak count of that specific user and page
                let newStreakCount = (currentStreakDictionary[user]?["currentStreak"]?["count"] as? Int)! + 1
                currentStreakDictionary[user] = updateCurrentStreak(page: page, count: newStreakCount)
                
                //Add apacheLog to the dictionary if streak is greater than 3
                if newStreakCount >= 3 {
                    threePageSequenceDictionary["\(user) \(page)"] = updateThreePageSequence(count: threePageSequenceDictionary["\(user) \(page)"])
                }
            } else {
                currentStreakDictionary[user] = updateCurrentStreak(page: page, count: 1)
            }
        }
        
        print(threePageSequenceDictionary)
        print(currentStreakDictionary.count)
        
        for (key,value) in threePageSequenceDictionary {
            let user = key.components(separatedBy: " ")[0]
            let page = key.components(separatedBy: " ")[1]
            let count = value
            parsedApacheLogArray.append(ApacheLog(user: user, page: page, count: count))
        }
        
        return parsedApacheLogArray
        
    }
    
    func updateThreePageSequence(count: Int?) -> Int {
        if count != nil {
            return count! + 1
        } else {
            return 1
        }
    }
    
    func isPageEqual(newPage: String, oldPage: String?) -> Bool {
        if newPage == oldPage {
            return true
        } else {
            return false
        }
    }
    
    func updateCurrentStreak(page: String, count: Int) -> [String: [String:Any]] {
        
        return ["currentStreak" : ["name": page, "count": count]]
    }
}
