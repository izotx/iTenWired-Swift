//
//  FNBJSocialFeedViewController.swift
//  FNBJSocialFeed
//
//  Created by Felipe on 5/31/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.
//

import UIKit
import ALTextInputBar


class FNBJSocialFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ALTextInputBarDelegate {

    var feed: [FNBJSocialFeedFeedObject] = []
    var currentFeed : FNBJSocialFeedFeedObject? = nil
    
    var controller : FNBJSocialFeed!
    var paging = false
    
    let textInputBar = ALTextInputBar()
    let keyboardObserver = ALKeyboardObservingView()
    
    var currentEditingIndexPath: NSIndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    
    var newFeedButton: UIButton!
    
    
    // This is how we observe the keyboard position
    override var inputAccessoryView: UIView? {
        get {
            return keyboardObserver
        }
    }
    
    // This is also required
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        textInputBar.hidden = true
    }
    
    func checkForNewFeed(){
        
        print("Cheking for new feed...")
        
        controller.checkForNewFeed { (hasNewFeed) in
            
            if hasNewFeed{
                self.newFeedButton.hidden = false
            }
        }
    }
    
    func updateWithNewContent(){
        
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        self.newFeedButton.hidden = true
       
    
        if controller.hasViewPermissions(){
            controller.getFeed { (feed) in
                
                self.feed = []
                self.feed.appendContentsOf(feed)
                
                self.feed.sortInPlace({$0.date.isGreaterThanDate($1.date)})
                self.tableView.reloadData()
                
            }
        }else{
            
            controller.loginWithReadPermissions(self, completion: {
                
                self.controller.getFeed { (feed) in
                    
                    self.feed = []
                    self.feed.appendContentsOf(feed)
                    
                    self.feed.sortInPlace({$0.date.isGreaterThanDate($1.date)})
                    self.tableView.reloadData()
                    self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                }
            })
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = .blueColor()
        button.setTitle("New Feed Available", forState: .Normal)
        button.addTarget(self, action: #selector(updateWithNewContent), forControlEvents: .TouchUpInside)
        self.newFeedButton = button
        button.layer.cornerRadius = 10
        
        button.hidden = true
        self.view.addSubview(button)
        
        
        self.controller = FNBJSocialFeed(facebookPageID: "itenwired", twitterHashtag: "#itenwired16")
        
        self.textInputBar.delegate = self
        
        _ = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(checkForNewFeed), userInfo: nil, repeats: true)
        
        configureInputBar()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FNBJSocialFeedViewController.keyboardFrameChanged(_:)), name: ALKeyboardFrameDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FNBJSocialFeedViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FNBJSocialFeedViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
        // Tableview Delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        
        if controller.hasViewPermissions(){
            controller.getFeed { (feed) in
                
                self.feed.appendContentsOf(feed)
                
                self.feed.sortInPlace({$0.date.isGreaterThanDate($1.date)})
                self.tableView.reloadData()
            }
        }else{
        
            controller.loginWithReadPermissions(self, completion: {
                
                self.controller.getFeed { (feed) in
                    
                    self.feed.appendContentsOf(feed)
                    
                    self.feed.sortInPlace({$0.date.isGreaterThanDate($1.date)})
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.textInputBar.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let index = self.currentEditingIndexPath{
            if indexPath != index {
                let cell = tableView.dequeueReusableCellWithIdentifier("graycell")
                return cell!
            }
        }

        
        
        if indexPath.row + 5 > feed.count && paging != true{
            paging = true
            controller.getFeedPaging({ (feed) in
                var f = feed
                f.sortInPlace({$0.date.isGreaterThanDate($1.date)})
                self.feed.appendContentsOf(feed)
                self.tableView.reloadData()
                self.paging = false
            })
        }

        let f = feed[indexPath.row]
        
        if f.feed is FNBJSocialFeedFacebookPost{
        
            let post = f.feed as? FNBJSocialFeedFacebookPost
            
            //TODO: Create Enum
            if post!.type == "photo" || post!.type == "link"{
                
                let cell = tableView.dequeueReusableCellWithIdentifier("FacebookCell", forIndexPath:  indexPath) as? FacebookCell
                
                cell?.build(post!)
                
                cell?.setNeedsDisplay()
                cell?.layoutIfNeeded()
                return cell!
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier("FNBJSocialFeedFacebookCellTextOnly", forIndexPath:  indexPath) as? FNBJSocialFeedFacebookCellTextOnly
            cell?.build(post!)
            cell?.setNeedsDisplay()
            cell?.layoutIfNeeded()
            
            return cell!
            
        }else{
            
            let tweet = f.feed as? FNBJSocialFeedTwitterTweet
            
            let cell =  tableView.dequeueReusableCellWithIdentifier("FNBJtwitterCell", forIndexPath: indexPath) as? TwitterCell
            
            cell?.build(tweet!, indexPath: indexPath, callback: showKeyboard)
            cell?.setNeedsDisplay()
            cell?.layoutIfNeeded()
            
            return cell!
        }
    }
    
    //TODO: Rename
    func showKeyboard(feed: FNBJSocialFeedFeedObject, indexPath: NSIndexPath){
        self.textInputBar.hidden = false
        self.textInputBar.textView.becomeFirstResponder()
        
        if feed.feed is FNBJSocialFeedTwitterTweet{
        
            let tweet = feed.feed as? FNBJSocialFeedTwitterTweet
            
            if let unwrapedScreenName = tweet?.user.screenName {
                let screenName = "@\(unwrapedScreenName) "
                self.textInputBar.textView.text = screenName
                self.textInputBar.textView.placeholder = ""
            }
            
            self.currentFeed = feed
            
            if let button = self.textInputBar.rightView as? UIButton{
                
                button.addTarget(self, action: #selector(replyToTweet), forControlEvents: .TouchUpInside)
            }
        }
        
        self.currentEditingIndexPath = indexPath
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(endTyping))
        self.tableView.scrollEnabled = false
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.reloadRowsAtIndexPaths(self.tableView.indexPathsForVisibleRows!, withRowAnimation: .Automatic)
        
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
 
    }
    
    internal func endTyping(){
        self.tableView.scrollEnabled = true
        self.currentFeed = nil
        
        self.view.endEditing(true)
        self.textInputBar.hidden = true
        self.currentEditingIndexPath = nil
        self.tableView.reloadData()
        
        navigationItem.rightBarButtonItem = nil
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func replyToTweet(sender: AnyObject){
        
        let message = self.textInputBar.textView.text
        let tweet = FNBJSocialFeedTwitterTweet()
        tweet.text = message
        let inReplyTo = self.currentFeed?.feed as? FNBJSocialFeedTwitterTweet
        self.controller.replyToTweet(tweet, inReplyTo: inReplyTo!)
        
        self.endTyping()
    }
}



//MARK: ALTextInputBar
extension FNBJSocialFeedViewController{

    func configureInputBar() {
        // Configure send button
        let rightButton = UIButton(frame: CGRectMake(100, 100, 80, 50))
        rightButton.setTitle("Send", forState: .Normal)
        rightButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        keyboardObserver.userInteractionEnabled = false
        
        textInputBar.showTextViewBorder = true
        textInputBar.rightView = rightButton
        textInputBar.frame = CGRectMake(0, view.frame.size.height - textInputBar.defaultHeight, view.frame.size.width, textInputBar.defaultHeight)
        textInputBar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textInputBar.keyboardObserver = keyboardObserver
        
        view.addSubview(textInputBar)
        
    }
    
    func keyboardFrameChanged(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y
            self.textInputBar.hidden = false
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            textInputBar.frame.origin.y = frame.origin.y + textInputBar.frame.size.height
        }
        self.textInputBar.hidden = true
    }
}


extension FNBJSocialFeedViewController{

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textInputBar.frame.size.width = view.bounds.size.width
    }
}

