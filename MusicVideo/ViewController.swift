//
//  ViewController.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/29/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()  // created this array to hold all our fetched videos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call API
        let api = APIManager()
        
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//            (result:String) in
//            print(result)
//        }
        
        // step 1
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",
                    completion: didLoadData)  // when done, executes didLoadData
    }

    func didLoadData(videos: [Videos]) {  // step 8
        
        self.videos = videos  // stored in class instance
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        // Best
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }

        // Better
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
 
        // Not good - old style
//        for var i = 0; i < videos.count; i++ {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
    }
    
}

