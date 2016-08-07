//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/31/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()  // created this array to hold all our fetched videos
    var filterSearch = [Videos]()
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChanged() {
        
        print("The preferred Font has changed")
    }
    
    func didLoadData(videos: [Videos]) {  // step 8
        
        print(reachabilityStatus)
        
        self.videos = videos  // stored in class instance
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        // Setup the Search Controller
        
        //resultSearchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        
        resultSearchController.searchBar.placeholder = "Search for Artist"
        
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        // add the search bar to your tableview
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged()
    {
        
        switch reachabilityStatus {
            
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            // Move back to main queue because viewDidLoad hasn't finished and no view on screen yet, so get the
            // console Warning message "Presenting view controllers on detached view controllers is discouraged"
            // Dispatching to main queue fixes this because it asynchronously runs this code, giving view time to appear first
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                    action -> () in
                    print("Delete")
                }
                
                let okAction = UIAlertAction(title: "Ok", style: .Default) {
                    action -> () in
                    print("Ok")
                    
                    // do something if you want
                    //alert.dismissViewControllerAnimated(true, completion: nil)
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
        
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        runAPI()
        
    }
    
    func getAPICount() {
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
        }
        
        let formatter = NSDateFormatter()
         formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
            
    }
    
    func runAPI() {
        
        getAPICount()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json",
                     completion: didLoadData)  // when done, executes didLoadData
        
    }
    
    // Is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active {
            return filterSearch.count
        } else {
            return videos.count
        }
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        } else {
            cell.video = videos[indexPath.row]
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == storyboard.segueIdentifier {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let video: Videos
                if resultSearchController.active {
                    video = filterSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }

}
