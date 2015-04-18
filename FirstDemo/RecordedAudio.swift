//
//  RecordedAudio.swift
//  FirstDemo
//
//  Created by Bowen Fan on 4/9/15.
//  Copyright (c) 2015 Bowen Fan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    /**
        This class is for storing filepath and title of a audio file.
    */
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
