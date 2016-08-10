//
//  JsonDataExtractor.swift
//  MusicVideo
//
//  Created by David Cutshaw on 8/10/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class JsonDataExtractor {
    
    static func extractVideoDataFromJson(videoDataObject: AnyObject) -> [Video] {
        
        guard let videoData = videoDataObject as? JSONDictionary else { return [Video]() }
        
        var videos = [Video]()
        
        if let feeds = videoData["feed"] as? JSONDictionary, entries = feeds["entry"] as? JSONArray {
            
            for (index, data) in entries.enumerate() {
                
                var vName = " ", vRights = "", vPrice = "", vImageUrl = "",
                vArtist = "", vVideoUrl = "", vImid = "", vGenre = "",
                vLinkToiTunes = "", vReleaseDate = ""
                
                // Video Name
                if let imName = data["im:name"] as? JSONDictionary,
                    label = imName["label"] as? String {
                    vName = label
                }
                
                // Video Rights
                if let rights = data["rights"] as? JSONDictionary,
                    label = rights["label"] as? String {
                    vRights = label
                }
                
                // Video Price
                if let imPrice = data["im:price"] as? JSONDictionary,
                    label = imPrice["label"] as? String {
                    vPrice = label
                }
                
                // The Video Image
                if let imImage = data["im:image"] as? JSONArray,
                    image = imImage[2] as? JSONDictionary,
                    label = image["label"] as? String {
                    
                    vImageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "300x300")
                    if NSUserDefaults.standardUserDefaults().boolForKey("BestImageQualSetting") == true && reachabilityStatus == WIFI {
                        vImageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
                        
                    }
                }
                
                // The Artist
                if let imArtist = data["im:artist"] as? JSONDictionary,
                    label = imArtist["label"] as? String {
                    vArtist = label
                }
                
                // Video Url
                if let link = data["link"] as? JSONArray,
                    link1 = link[1] as? JSONDictionary,
                    attributes = link1["attributes"] as? JSONDictionary,
                    href = attributes["href"] as? String {
                    vVideoUrl = href
                }
                
                // Imid
                if let id = data["id"] as? JSONDictionary,
                    attributes = id["attributes"] as? JSONDictionary,
                    imId = attributes["im:id"] as? String {
                    vImid = imId
                }
                
                // Genre
                if let category = data["category"] as? JSONDictionary,
                    attributes = category["attributes"] as? JSONDictionary,
                    term = attributes["term"] as? String {
                    vGenre = term
                }
                
                // Link to iTunes
                if let link = data["link"] as? JSONArray,
                    link1 = link[1] as? JSONDictionary,
                    attributes = link1["attributes"] as? JSONDictionary,
                    href = attributes["href"] as? String {
                    vLinkToiTunes = href
                }
                
                // Release date
                if let imRelease = data["im:releaseDate"] as? JSONDictionary,
                    attributes = imRelease["attributes"] as? JSONDictionary,
                    label = attributes["label"] as? String {
                    vReleaseDate = label
                }
                
                let currentVideo = Video(vRank: index + 1, vName: vName, vRights: vRights, vPrice: vPrice, vImageUrl: vImageUrl, vArtist: vArtist, vVideoUrl: vVideoUrl, vImid: vImid, vGenre: vGenre, vLinkToiTunes: vLinkToiTunes, vReleaseDate: vReleaseDate)
                
                videos.append(currentVideo)
                
            }
            
        }
        
        return videos
        
    }
}
