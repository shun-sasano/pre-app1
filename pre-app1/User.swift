//
//  User.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/12.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var password: String
    
    init(name: String ,password: String) {
        self.name = name
        self.password = password
    }
    
    func signUp(){
        let user = NCMBUser()
        user.userName = name
        user.password = password
        user.signUpInBackgroundWithBlock{(error: NSError!) in
            if error != nil {
                // 新規登録失敗時の処理
                
            }else{
                // 新規登録成功時の処理
                
            }
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        NCMBUser.logInWithUsernameInBackground(self.name, password: self.password) { (user, error) in
            callback(message: error?.userInfo["NSLocalizedDescription"] as? String)
        }
    }

}
