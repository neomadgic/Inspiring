//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var apacheLog = [ApacheLog]()
    
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
//                for x in 0...apacheLogArray.count - 2{
//                    self.apacheLog.append(self.parseApacheLog(with: apacheLogArray[x]))
//                }
                
                for x in 1...2500 {
                    if self.isThreePageSequence(log: apacheLogArray[x], logBefore: apacheLogArray[x-1], logAfter: apacheLogArray[x+1]) == true {
                        self.apacheLog.append(self.parseApacheLog(with: apacheLogArray[x]))
                    }
                }
                
//                print(self.isThreePageSequence(log: apacheLogArray[0], logBefore: apacheLogArray[0], logAfter: apacheLogArray[0]))
                
                
            } catch let error as NSError{
                print(error)
            }
            
            DispatchQueue.main.async {
                print(self.apacheLog)
            }
        }
    }
    
    func parseApacheLog(with: String) -> ApacheLog {
    
        let user = with.components(separatedBy: " ")[0]
        let page = with.components(separatedBy: " ")[6]

        return ApacheLog(user: user, page: page)
    }
    
//    func isThreePageSequence(log: String, logBefore: String, logAfter: String) -> Bool {
//        
//        let parsedApacheLog = parseApacheLog(with: log)
//        let parsedApacheLogBefore = parseApacheLog(with: logBefore)
//        
//        parsedApacheLog.printLog()
//        parsedApacheLogBefore.printLog()
//        print(parsedApacheLog != parsedApacheLogBefore)
//        
//        if parsedApacheLog != parsedApacheLogBefore {
//            return false
//        }
//        
//        let parsedApacheLogAfter = parseApacheLog(with: logAfter)
//        parsedApacheLogAfter.printLog()
//        print(parsedApacheLog != parsedApacheLogAfter)
//        
//        if parsedApacheLog != parsedApacheLogAfter {
//            return false
//        }
//        
//        print("We made it here")
//        
//        return true
//    }
}

