//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/31/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Video? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: CustomImageView!

    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {

        if let _ = video {  // to make sure video is not nil
            musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            
            musicTitle.text = video?.vName
            rank.text = ("\(video!.vRank)")
           // musicImage.image = UIImage(named: "imageNotAvailable")
            
            if video!.vImageData != nil {
                print("Get data from array ...")
                musicImage.image = UIImage(data: video!.vImageData!)
            } else {
                print("Get data from internet ...")
                GetVideoImage(video!, imageView: musicImage)
            }
        }
    }
    
    func GetVideoImage(video: Video, imageView : CustomImageView){
        
        // Background thread
        //  DISPATCH_QUEUE_PRIORITY_HIGH Items dispatched to the queue will run at high priority, i.e. the queue will be scheduled for execution before any default priority or low priority queue.
        //
        //  DISPATCH_QUEUE_PRIORITY_DEFAULT Items dispatched to the queue will run at the default priority, i.e. the queue will be scheduled for execution after all high priority queues have been scheduled, but before any low priority queues have been scheduled.
        //
        //  DISPATCH_QUEUE_PRIORITY_LOW Items dispatched to the queue will run at low priority, i.e. the queue will be scheduled for execution after all default priority and high priority queues have been scheduled.

        
        imageView.loadImageUsingUrlString(video.vImageUrl, video: video)  // this takes place of dispatch.... code below
        
        
/*
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
//                print("image from video with vRank - 1 = \(video.vRank - 1) for cell \(self.musicImage.tag)")
            }
        
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image!
//                print("new image assigned - \(self.musicImage.image) - at tag -  \(self.musicImage.tag) rank - 1 = \(video.vRank - 1)\n")
            }
        }
*/
    }
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.musicImage.image = nil
    }
    
}
