//
//  MathViewController.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/15.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import UIKit

class MathViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brownColor()
        
        let frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let tableView = MathTableView(frame: frame,style: .Plain)
        self.view.addSubview(tableView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
