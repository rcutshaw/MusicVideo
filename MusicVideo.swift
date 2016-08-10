//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by David Cutshaw on 7/30/16.
//  Copyright © 2016 Bit Smartz LLC. All rights reserved.
//

import Foundation

class Video {
    
    // Data Encapsulation
    private(set) var vRank:Int
    private(set) var vName:String
    private(set) var vRights:String
    private(set) var vPrice:String
    private(set) var vImageUrl:String
    private(set) var vArtist:String
    private(set) var vVideoUrl:String
    private(set) var vImid:String
    private(set) var vGenre:String
    private(set) var vLinkToiTunes:String
    private(set) var vReleaseDate:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    init(vRank:Int, vName:String, vRights:String, vPrice:String,                // step 3
         vImageUrl:String, vArtist:String, vVideoUrl:String, vImid:String,
         vGenre:String, vLinkToiTunes:String, vReleaseDate:String) {
        
        
        self.vRank = vRank
        self.vName = vName
        self.vRights = vRights
        self.vPrice = vPrice
        self.vImageUrl = vImageUrl
        self.vArtist = vArtist
        self.vVideoUrl = vVideoUrl
        self.vImid = vImid
        self.vGenre = vGenre
        self.vLinkToiTunes = vLinkToiTunes
        self.vReleaseDate = vReleaseDate
        
    }
}