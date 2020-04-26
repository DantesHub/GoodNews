//
//  Tweet.swift
//  GoodNews
//
//  Created by Raymond Yoo on 4/26/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let likes: Int
    let uid: String
    let timeStamp: String
    let retweet: Int
    let profilePic: String
    
    init(tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweet = dictionary["retweet"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? String ?? ""
        self.profilePic = dictionary["propic"] as? String ?? ""
    }
}
