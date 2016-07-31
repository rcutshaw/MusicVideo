//
//  APIManager.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/29/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: [Videos] -> Void ) {  // step 2 and step 7
        
        // sets up a non-cached session instead of the normal cached session below
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
//        let session = NSURLSession.sharedSession() // normal cached session
        
        let url = NSURL(string: urlString)!

        let task = session.dataTaskWithURL(url) {  // step 3
            (data, response, error) -> Void in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                //Added for JSONSerialization
                //print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                     Any type of string or value
                     NSJSONSerialization requires the Do / Try / Catch
                     Converts the NSDATA into a JSON Object and cast it to a Dictionary */
                    
                    // step 3
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                        
                        var videos = [Videos]()
                        for (index, entry) in entries.enumerate() {
                            let entry = Videos(data: entry as! JSONDictionary)
                            entry.vRank = index + 1
                            videos.append(entry)
                        }
                        
                        
                        let i = videos.count
                        print("iTunesApiManager - total count --> \(i)")  // step 5
                        print(" ")
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT  // step 6
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(videos)
                            }
                        }
                    }
                } catch {
                    print("error in NSJSONSerialization")
                    
                }
                
            }
        }
        
        task.resume()

    }
}