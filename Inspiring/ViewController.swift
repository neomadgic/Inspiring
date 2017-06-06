//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var testDictionary = [String:Int]()
    var apacheDictionary = [String: [String: [String:Any]]]()
    var apacheLog = [ApacheLog]()
    var letsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadApacheLog()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadApacheLog() {
        
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: "http://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log")
            do {
                let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                let apacheLogArray = urlContents.components(separatedBy: "\n")
                
                for x in 0...apacheLogArray.count - 2 {
                    
                    let user = apacheLogArray[x].components(separatedBy: " ")[0]
                    let page = apacheLogArray[x].components(separatedBy: " ")[6]
                    
                    
                    if let oldPage = self.apacheDictionary[user]?["currentStreak"]?["name"] as? String {
                        if self.isPageEqual(newPage: page, oldPage: oldPage) {
                            let oldCount = (self.apacheDictionary[user]?["currentStreak"]?["count"] as? Int)!
                            self.apacheDictionary[user] = ["currentStreak" : ["name": page, "count": oldCount + 1]]
                            if oldCount + 1 >= 3 {
                                if let threePageCount = self.testDictionary["\(user) \(page) count"] {
                                    self.testDictionary["\(user) \(page) count"] = threePageCount + 1
                                } else {
                                    self.testDictionary["\(user) \(page) count"] = 1
                                    self.apacheLog.append(ApacheLog(user: user, page: page, count: 0))
                                }
                            }
                            self.letsCount += 1
                        } else {
                            self.apacheDictionary[user] = ["currentStreak" : ["name": page, "count": 1]]
                            self.letsCount += 1
                        }
                    } else {
                        self.apacheDictionary[user] = ["currentStreak" : ["name": page, "count": 1]]
                        self.letsCount += 1
                    }
                    
                    
                }
                
                
            } catch let error as NSError{
                print(error)
            }
            
            DispatchQueue.main.async {
                print(self.apacheDictionary.count)
                print(self.testDictionary.count)
                print(self.apacheLog[0].printLog())
            }
        }
    }
    
    func parseApacheLog(with: String) -> ApacheLog {
    
        let user = with.components(separatedBy: " ")[0]
        let page = with.components(separatedBy: " ")[6]

        return ApacheLog(user: user, page: page, count: 0)
    }
    
    func isPageEqual(newPage: String, oldPage: String?) -> Bool {
        if newPage == oldPage {
            return true
        } else {
            return false
        }
    }
}

