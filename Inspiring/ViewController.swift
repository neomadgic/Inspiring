//
//  ViewController.swift
//  Inspiring
//
//  Created by Vu Dang on 6/3/17.
//  Copyright © 2017 Vu Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "http://dev.inspiringapps.com/Files/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log")
        do{
            let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            
            print(urlContents)
        }catch let error as NSError{
            print(error)
        }
//        URLSession.shared.dataTask(with: url!, completionHandler: {
//            (data, response, error) in
//            if(error != nil){
//                print("error")
//            }else{
//                do{
//                    let urlContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
//                    
//                    print(urlContents)
//                }catch let error as NSError{
//                    print(error)
//                }
//            }
//        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

