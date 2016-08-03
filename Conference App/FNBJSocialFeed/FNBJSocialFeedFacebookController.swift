//Copyright (c) 2016, Academic Technology Center
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//
//* Redistributions of source code must retain the above copyright notice, this
//list of conditions and the following disclaimer.
//
//* Redistributions in binary form must reproduce the above copyright notice,
//this list of conditions and the following disclaimer in the documentation
//and/or other materials provided with the distribution.
//
//* Neither the name of FNBJSocialFeed nor the names of its
//contributors may be used to endorse or promote products derived from
//this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//  FNBJSocialFeedFacebookController.swift
//  FNBJSocialFeed
//
//  Created by Felipe Brito on 5/27/16.
//  Copyright © 2016 Academic Technology Center. All rights reserved.

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

/// Check for details: https://developers.facebook.com/docs/facebook-login/permissions
enum FNBJSocialFeedFacebookPermissionsEnum : String {
    case public_profile
    case user_friends
    case email
    case user_about_me
    case publish_actions
    
    static func toStrings(permissions: [FNBJSocialFeedFacebookPermissionsEnum]) -> [String]{
    
        var permissionsStrings:[String] = []
        
        for permission in permissions{
            permissionsStrings.append(permission.rawValue)
        }
        return permissionsStrings
    }
}

enum FNBJSocailFeedEnum : String{
    case FNBJSocialFeedFacebookReadToken
    case FNBJSocialFeedFacebookPublishToken
}

enum FNBJNotificationCenterEnum : String {
    case LoginReadPermissionGaranted
}

/// Handles Facebook Operations
class FNBJSocialFeedFacebookController{
    
    var pageID = ""
    
    init(pageID: String){
        self.pageID = pageID
    }

    func loginWithReadPermissions(permissions: [FNBJSocialFeedFacebookPermissionsEnum], fromViewController: UIViewController!, completion: () -> Void){
        
        let loginView : FBSDKLoginManager = FBSDKLoginManager()
        loginView.loginBehavior = FBSDKLoginBehavior.Browser
        
        let permissionsStrings = FNBJSocialFeedFacebookPermissionsEnum.toStrings(permissions)
        
        loginView.logInWithReadPermissions(permissionsStrings, fromViewController: fromViewController, handler: { (result : FBSDKLoginManagerLoginResult!, error : NSError!) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Login Error")
            }
            else if result.isCancelled {
                // Handle cancellations
                print("canceled")
            }
            else {
                NSUserDefaults.standardUserDefaults().setObject(result.token.tokenString, forKey: FNBJSocailFeedEnum.FNBJSocialFeedFacebookReadToken.rawValue)
    
                
                completion()
            }
        })
    }
    
    func loginWithPostPermissions(permissions: [FNBJSocialFeedFacebookPermissionsEnum], fromViewController: UIViewController!, completion: () -> Void){
    
        
        let loginView : FBSDKLoginManager = FBSDKLoginManager()
        loginView.loginBehavior = FBSDKLoginBehavior.Browser
        
        let permissionsStrings = FNBJSocialFeedFacebookPermissionsEnum.toStrings(permissions)
        
        
        loginView.logInWithPublishPermissions(permissionsStrings, handler: {
            (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            
            if error != nil{
                // process error 
                print("login error")
            }else if result.isCancelled {
                // process cancel
                print("Canceled Login")
            }else {
            
                NSUserDefaults.standardUserDefaults().setObject(result.token.tokenString, forKey: FNBJSocailFeedEnum.FNBJSocialFeedFacebookPublishToken.rawValue)
                
               
                completion()
            }
        })
    }
    
    func postPublicPageSocialFeed(withPageId id: String, params: NSDictionary, completion:
        (posts: [FNBJSocialFeedFacebookPost]) -> Void){
    
        //let permissions: [String] = []
        let tokenString = NSUserDefaults.standardUserDefaults().stringForKey(FNBJSocailFeedEnum.FNBJSocialFeedFacebookPublishToken.rawValue)
        
        if tokenString == nil{
            return
        }
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "\(id)/posts", parameters: ["message": "iTenWired"], tokenString: tokenString, version: nil, HTTPMethod: "POST")
        
        graphRequest.startWithCompletionHandler(({
            (connection, result, error) -> Void in
            
            if error != nil{
                print("error")
            }else {
            
                
            }
        
        }))
    }
    
    func hasViewPermission() -> Bool{
        
        if let accessToken = FBSDKAccessToken.currentAccessToken(){
            return accessToken.hasGranted(FNBJSocialFeedFacebookPermissionsEnum.public_profile.rawValue)
        }
        return false
    }
    
    func checkForNewPosts(oldPosts: [FNBJSocialFeedFacebookPost], completion: (hasNewPosts : Bool) -> Void){
        
        if self.hasViewPermission() {
        
            self.getPublicPageSocialFeed(withPageId: self.pageID, completition: { (posts, pagingToken) in
                
                guard var new = posts as? [FNBJSocialFeedFacebookPost],
                        var old = oldPosts as? [FNBJSocialFeedFacebookPost] else {
                    
                            completion(hasNewPosts: false)
                            return
                }

                new.sortInPlace({$0.created_time.isGreaterThanDate($1.created_time)})
                old.sortInPlace({$0.created_time.isGreaterThanDate($1.created_time)})
                
                if new[0].created_time.isGreaterThanDate(old[0].created_time){
                    completion(hasNewPosts: true)
                    return
                }
               
            })
        }
        
        completion(hasNewPosts: false)
    }
    
    func getPublicPageSocialFeed(withPageId id: String, completition: (posts: [FNBJSocialFeedFacebookPost], pagingToken: String) -> Void){
        
        let tokenString = NSUserDefaults.standardUserDefaults().stringForKey(FNBJSocailFeedEnum.FNBJSocialFeedFacebookReadToken.rawValue)
        
        if tokenString == nil{
            return
        }
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "\(id)/posts", parameters: ["fields": "message,name,from,object_id,type,created_time,link,picture"], tokenString: tokenString, version: nil, HTTPMethod: nil)
        
        graphRequest.startWithCompletionHandler(({ (connection, result, error) -> Void in
        
            if error != nil {
                print(error)
            
            }else{
                
                var posts: [FNBJSocialFeedFacebookPost] = []
                
                for data in (result.valueForKey("data") as? NSArray)!{
                    
                    let post = FNBJSocialFeedFacebookPost(dictionary: data as! NSDictionary)
                    posts.append(post)
                }
                
                let paging = result.objectForKey("paging") as? NSDictionary
                let next = paging?.objectForKey("next") as? String

                completition(posts: posts, pagingToken: next!)
            }
        
        }))
    }
    
    func getPublicPageSocialFeedPaging(pagingToken: String, completition: (posts: [FNBJSocialFeedFacebookPost], nextToken: String) -> Void){
    
        let tokenString = NSUserDefaults.standardUserDefaults().stringForKey(FNBJSocailFeedEnum.FNBJSocialFeedFacebookReadToken.rawValue)
        
        if tokenString == nil{
            return
        }
        
        let url = NSURL(string: pagingToken)
        
        
        FNBJSocialFeedNetwork.getDataFromURL(url!) { (data) in
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                
                    print(json)
                    var posts: [FNBJSocialFeedFacebookPost] = []
                    for postData in (json.objectForKey("data") as? NSArray)!{

                        let post = FNBJSocialFeedFacebookPost(dictionary: postData as! NSDictionary)
                        posts.append(post)
                        print(post.fromName)
        
                    }
                    
                    completition(posts: posts, nextToken: json.objectForKey("paging")?.objectForKey("next") as! String)
                    
                }
            } catch{
            
            }
        }
    }
    
    
    func getPostImage(withObjectId object_id: String, completion: (imageUrl: String) -> Void){
        
        //let permissions: [String] = []
        let tokenString = NSUserDefaults.standardUserDefaults().stringForKey(FNBJSocailFeedEnum.FNBJSocialFeedFacebookReadToken.rawValue)
        
        if tokenString == nil{
            return
        }
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: object_id, parameters: ["fields": "images"], tokenString: tokenString, version: nil, HTTPMethod: nil)
        
        graphRequest.startWithCompletionHandler(({ (connection, result, error) -> Void in
            
            if error != nil {
                print("error")
                
            }else{
                
                //FIXME:
                var img = ""
                let data = result.objectForKey("images") as? NSArray
                let url = data![0] as? NSDictionary
                
                img = (url?.objectForKey("source")!)! as! String
                completion(imageUrl: img)
            }
            
        }))
        
    }
    
    func getUserProfile(profile_id:String, completion: (user: FNBJSocialFeedFacebookUser) -> Void){
        
        
        //let permissions: [String] = []
        let tokenString = NSUserDefaults.standardUserDefaults().stringForKey(FNBJSocailFeedEnum.FNBJSocialFeedFacebookReadToken.rawValue)
        
        if tokenString == nil{
            return
        }

    
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: profile_id, parameters: ["fields": "name,picture"], tokenString: tokenString, version: nil, HTTPMethod: nil)
        
    
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            
            if let picture = result.objectForKey("picture") as? NSDictionary{
            
                if let data = picture.objectForKey("data") as? NSDictionary{
                
                    if let url = data.objectForKey("url") as? String{
                    
                        let user = FNBJSocialFeedFacebookUser()
                        user.profilePicture = url                        
                        completion(user: user)
                    }
                }
            
            }
        }
    }
}

















