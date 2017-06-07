//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = "http://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log"
    var apacheLog = [ApacheLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.instance.downloadApacheLog(withURL: url) { (fullApacheLog, error) in
            
            if error == nil {
                let apacheLogParser = ApacheLogParser()
                
                DispatchQueue.global(qos: .background).async {
                    self.apacheLog = apacheLogParser.parse(apacheLog: fullApacheLog)
                    
                    DispatchQueue.main.async {
                        print(self.apacheLog)
                    }
                }
            } else {
                print(error.debugDescription)
            }
            
        }
    }
}

