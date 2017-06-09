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
    
    func downloadApacheLog(withURL: String, completion: @escaping (_ fullApacheLog: String, _ error: NSError?) -> Void) {
        
        var fullApacheLog = ""

        DispatchQueue.global(qos: .background).async {
            
            let url = URL(string: withURL)
            do {
                
                //Download content
                let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                fullApacheLog = urlContents
                
            } catch let error as NSError{
                print(error)
                completion(fullApacheLog, error)
            }
            
            DispatchQueue.main.async {
                completion(fullApacheLog, nil)
            }
        }
    }
}
