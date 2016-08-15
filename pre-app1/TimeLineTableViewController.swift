//
//  TImeLineTableViewController.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/11.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import UIKit
import PageMenu

class TimeLineTableViewController: UITableViewController {
    let tweetManager = TweetManager.sharedInstance
    
    var pageMenuModel = PageMenuModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tweetManager.fetchTweets { () in
            self.tableView.reloadData()
        }
        
        let controller1:MathViewController = MathViewController(nibName: "MathViewController",bundle: nil)
        controller1.title = "数学"
        let controller2:MathViewController = MathViewController(nibName: "MathViewController",bundle: nil)
        controller2.title = "国語"
        let controller3 = UIViewController()
        controller3.title = "英語"
        controller3.view.backgroundColor = UIColor.blueColor()
        let controller4 = UIViewController()
        controller4.title = "社会"
        let controller5 = UIViewController()
        controller5.title = "理科"
        
        pageMenuModel.addController(controller1)
        pageMenuModel.addController(controller2)
        pageMenuModel.addController(controller3)
        pageMenuModel.addController(controller4)
        pageMenuModel.addController(controller5)
        pageMenuModel.setPageMenu(self)
        if NCMBUser.currentUser() == nil{
       performSegueWithIdentifier("modalLoginViewController", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetManager.tweets.count
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = tweet.user?.name
        cell.titleLabel.text = tweet.title
        
        

        // Configure the cell...

        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .Plain, target: self, action: #selector(TimeLineTableViewController.tweetViewBuild))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "ログアウト",style: .Plain,target: self,action: #selector(TimeLineTableViewController.logout))

    }
    func logout(){
        NCMBUser.logOut()
        performSegueWithIdentifier("modalLoginViewController", sender: nil)
        
    }
    
    var chatTitle = ""
    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        
        cell.titleLabel.text = tweet.title
        chatTitle = cell.titleLabel.text!
        print("\(chatTitle)")
       
            performSegueWithIdentifier("chatViewController",sender: nil)
        print("gush")
        
        
    }
    
    var backTweetView: UIView!
    var textField: UITextField!
    var textView: UITextView!

    
    func tweetViewBuild() {
        backTweetView = self.makeBackTweetView()
        self.view.addSubview(backTweetView)
        
        let tweetView = makeTweetView()
        backTweetView.addSubview(tweetView)
        
        textField = self.makeTextField()
        tweetView.addSubview(textField)
        
        textView = self.makeTextView()
        tweetView.addSubview(textView)
        
        let nameLabel = makeLabel("タイトル", y: 5)
        tweetView.addSubview(nameLabel)
        
        let tweetLabel = makeLabel("ツイート内容", y: 85)
        tweetView.addSubview(tweetLabel)
        
        let cancelBtn = makeCancelBtn(tweetView)
        tweetView.addSubview(cancelBtn)
        
        let submitBtn = makeSubmitBtn()
        tweetView.addSubview(submitBtn)
    }
    func makeBackTweetView() -> UIView {
        backTweetView = UIView()
        backTweetView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        backTweetView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return backTweetView
    }
    
    func makeTweetView() -> UIView {
        let tweetView = UIView()
        tweetView.frame.size = CGSizeMake(300,300)
        tweetView.center.x = self.view.center.x
        tweetView.center.y = 250
        tweetView.backgroundColor = UIColor.whiteColor()
        tweetView.layer.shadowOpacity = 0.3
        tweetView.layer.cornerRadius = 3
        return tweetView
        
    }
    
    func makeTextField() -> UITextField {
        textField = UITextField()
        textField.frame = CGRectMake(10, 40, 280, 40)
        textField.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        return textField
    }
    
    func makeTextView() -> UITextView {
        textView = UITextView()
        textView.frame = CGRectMake(10, 120, 280, 110)
        textView.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).CGColor
        textView.layer.borderWidth = 1
        return textView
    }
    
    func makeLabel(text: String, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRectMake(10, y, 280, 40))
        label.text = text
        label.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        return label
    }
    
    func makeCancelBtn(tweetView: UIView) -> UIButton {
        let cancelBtn = UIButton()
        cancelBtn.frame.size = CGSizeMake(20, 20)
        cancelBtn.center.x = tweetView.frame.width-15
        cancelBtn.center.y = 15
        cancelBtn.setBackgroundImage(UIImage(named: "cancel.png"), forState: .Normal)
        cancelBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        cancelBtn.layer.cornerRadius = cancelBtn.frame.width / 2
        cancelBtn.addTarget(self, action: #selector(TimeLineTableViewController.tappedCancelBtn(_:)), forControlEvents:.TouchUpInside)

        return cancelBtn
    }
    
    func tappedCancelBtn(sender: AnyObject) {
        backTweetView.removeFromSuperview()

    }
    
    func tappedSubmitBtn(sender :AnyObject){
        let tweet = Tweet(title: textField.text!, content: textView.text!)
        tweet.save { () in
            self.tweetManager.fetchTweets { ()  in
                self.tableView.reloadData()
            }
        }

        backTweetView.removeFromSuperview()
        textField.text = ""
        textView.text = ""

    }
    
    func makeSubmitBtn() -> UIButton {
        let submitBtn = UIButton()
        submitBtn.frame = CGRectMake(10, 250, 280, 40)
        submitBtn.setTitle("送信", forState: .Normal)
        submitBtn.titleLabel?.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        submitBtn.backgroundColor = UIColor(red: 0.14, green: 0.3, blue: 0.68, alpha: 1.0)
        submitBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        submitBtn.layer.cornerRadius = 7
        submitBtn.addTarget(self, action: #selector(TimeLineTableViewController.tappedSubmitBtn(_:)), forControlEvents:.TouchUpInside)

        return submitBtn
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "chatViewController" {
            let nav = segue.destinationViewController as! UINavigationController
            let chatViewController = nav.topViewController as! ChatViewController
            
            
            // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
            // segue.destinationViewController は遷移先のViewController
            print("\(chatTitle)")
            chatViewController.chatTitle = chatTitle
            print("\(chatViewController.chatTitle)")
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
