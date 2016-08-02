//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/30/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    
    // Data Encapsulation
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    // Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    init(data: JSONDictionary) {  // step 4
        
        // If we do not inialize all properties, we will get error message
        // Return from inializer without initializing all stored properties
        
        // Video Name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
                self._vName = vName
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vName = ""
        }
        
        // Video Rights
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
            self._vRights = vRights
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vRights = ""
        }
        
        // Video Price
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vPrice = ""
        }
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            vImageUrl = image["label"] as? String {
                _vImageUrl = vImageUrl.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vImageUrl = ""
        }
        
        // The Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vArtist = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vVideoUrl = ""
        }
        
        // Imid
        if let imid = data["id"] as? JSONDictionary,
            vid = imid["attributes"] as? JSONDictionary,
            vImid = vid["im:id"] as? String {
            self._vImid = vImid
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vImid = ""
        }
        
        // Genre
        if let genre = data["category"] as? JSONDictionary,
            ggenre = genre["attributes"] as? JSONDictionary,
            vGenre = ggenre["term"] as? String {
            self._vGenre = vGenre
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vGenre = ""
        }
        
        // Link to iTunes
        if let ltoitunes = data["link"] as? JSONArray,
            link1 = ltoitunes[1] as? JSONDictionary,
            vRef = link1["attributes"] as? JSONDictionary,
            vLinkToiTunes = vRef["href"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vLinkToiTunes = ""
        }
        
        // Release date
        if let release = data["im:releaseDate"] as? JSONDictionary,
            date = release["attributes"] as? JSONDictionary,
            vReleaseDate = date["label"] as? String {
            self._vReleaseDate = vReleaseDate
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // Element in the JSON is unexpected
            
            _vReleaseDate = ""
        }
    }
}