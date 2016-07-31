//
//  ViewController.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/29/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos = [Videos]()  // created this array to hold all our fetched videos
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//            (result:String) in
//            print(result)
//        }
        
        // step 1
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json",
                    completion: didLoadData)  // when done, executes didLoadData
    }

    func didLoadData(videos: [Videos]) {  // step 8
        
        print(reachabilityStatus)
        
        self.videos = videos  // stored in class instance
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        // Best
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }

        tableView.reloadData()
        
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
    
    func reachabilityStatusChanged()
    {
        
        switch reachabilityStatus {
            
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = "Reachable with Cellular"
        default:return
            
        }
        
    }
    
    // Is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)" )
        
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    
}

