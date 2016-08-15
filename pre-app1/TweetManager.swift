//
//  TweetManager.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/11.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    static let sharedInstance = TweetManager()
    var tweets: [Tweet] = []
    
    func fetchTweets(callback: () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        query.includeKey("user")
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock{ (objects ,error) in
            if error == nil {
                self.tweets = []
                for object in objects{
                    let title = object.objectForKey("title") as! String
                    let content = object.objectForKey("content") as! String
                    let userObject = object.objectForKey("user") as! NCMBUser
                    let user = User(name: userObject.userName, password: "")
            
                    let tweet = Tweet(title: title, content: content)
                    tweet.user = user
                    self.tweets.append(tweet)
                    callback()
                }
            }
        }
    }

}
