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
    
    func returnParsedApacheLog(withURL: String, completion: @escaping (_ parsedApacheLog: [ApacheLog], _ error: NSError?) -> Void) {
        
        let apacheLogParser = ApacheLogParser()
        var parsedApacheLogArray = [ApacheLog]()
        
        //Move into background thread
        DispatchQueue.global(qos: .background).async {
            
            let url = URL(string: withURL)
            do {
                
                //Download content
                let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                parsedApacheLogArray = apacheLogParser.parse(apacheLog: urlContents)
                
            } catch let error as NSError{
                print(error)
                completion(parsedApacheLogArray, error)
            }
            
            DispatchQueue.main.async {
                completion(parsedApacheLogArray, nil)
            }
        }
    }
}
