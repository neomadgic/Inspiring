//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var apacheDictionary = [String:Any]()
    var apacheLog = [ApacheLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apacheDictionary["John"] = "Butt"
        print(isPageEqual(newPage: "Butt", oldPage: apacheDictionary["John"] as! String?))
        
        
        //downloadApacheLog()
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

