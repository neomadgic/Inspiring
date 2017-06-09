//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let url = "http://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log"
    var apacheLog = [ApacheLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.instance.downloadApacheLog(withURL: url) { [weak self] (fullApacheLog, error) in
            if error == nil {
                let apacheLogParser = ApacheLogParser()
                DispatchQueue.global(qos: .background).async {
                    self?.apacheLog = apacheLogParser.parse(apacheLog: fullApacheLog)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apacheLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as? LogCell {
            cell.configureCell(with: apacheLog[indexPath.row])
            return cell
        } else {
            return LogCell()
        }
    }
}

