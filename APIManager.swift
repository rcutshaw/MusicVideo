//
//  APIManager.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/29/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void ) {  //  could have used -> () instead of Void (result:String is input to another method)
        
        // sets up a non-cached session instead of the normal cached session below
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
//        let session = NSURLSession.sharedSession() // normal cached session
        
        let url = NSURL(string: urlString)!

        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
                
            } else {
                
                // Added JSONSerialization
                //print(data!)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                        Any type of string or value
                        NSJSONSerialization requires the Do / Try / Catch
                        Converts the NSDATA into a JSON object and casts it to a Dictionary */
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!,
                    options: .AllowFragments)
                    as? [String: AnyObject] {
                        
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in NSJSONSerialization")
                    }
                }
                // End of JSONSerialization
            }
        }
        task.resume()
    }
}