
//
//  Tweet.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/11.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var title: String
    var content: String
    var user: User?
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func save(callback: () -> Void) {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject.setObject(title, forKey:"title")
        tweetObject.setObject(content, forKey: "content")
        tweetObject.setObject(NCMBUser.currentUser(), forKey: "user")
        tweetObject.saveInBackgroundWithBlock{ (error) in
            if error == nil {
                callback()
            }
        }
    }

}
