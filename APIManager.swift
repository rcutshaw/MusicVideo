//
//  APIManager.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/29/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void ) {  //  could have used -> () instead of Void
                                                                             //  result:String is input to another method
        //  This sets up a non-cached session instead of the normal sharedSession cached session below
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession() // normal cached session
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {  // kicks of an asynchronous communication task with our url
            
            (data, response, error) -> Void in  // get our 3 responses - data, response and error
            
            dispatch_async(dispatch_get_main_queue()) {  // move everything back to the main queue
                if error != nil {
                    completion(result: (error!.localizedDescription))  // move error into result
                    } else {
                    completion(result: "NSURLSession successful")  // move successful string into result
                    print(data)
                }
            }
        }
        task.resume()  // starts the task
    }
}