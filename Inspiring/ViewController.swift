//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var apacheLog = [String]()
    
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
                //print(urlContents.components(separatedBy: "\n")[80])
                self.apacheLog = urlContents.components(separatedBy: "\n")
                self.parseApacheLog(with: self.apacheLog[0])
            } catch let error as NSError{
                print(error)
            }
            
            DispatchQueue.main.async {
                //print(self.apacheLog)
            }
        }
    }
    
    func parseApacheLog(with: String) {
        
        var user = String()
        var request = String()
    
        user = with.components(separatedBy: " ")[0]
        request = "\(with.components(separatedBy: " ")[5]) \(with.components(separatedBy: " ")[6]) \(with.components(separatedBy: " ")[7])"
        
        print("\(user), \(request)")
    }
}

