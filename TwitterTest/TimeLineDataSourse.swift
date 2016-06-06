//
//  TimeLineDataSourse.swift
//  TwitterTest
//
//  Created by 小林 悠人 on 2016/06/01.
//  Copyright © 2016年 小林 悠人. All rights reserved.
//

import UIKit
import Accounts
import Social

class TimeLineDataSource: NSObject, UITableViewDataSource{
    
    
    private var tweet = ["iphone", "ipad", "ipod", "macbook"]
    
    //TimeLineViewCotrollerからログインアカウント情報の受取り
    var twAccount: ACAccount!
    
    func getTweet(){
        
        //APIのURLの指定
        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        //リクエストの情報の生成
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                URL: URL,
                                parameters: nil)
        
        //認証したアカウントの設定
        request.account = twAccount
        
        //APIコールの実行
        request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
            
            if error != nil {
                print("error is \(error)")
            }
            else {
                // 結果の表示
                /*
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(responseData,
                        options: .AllowFragments) as! NSDictionary
                    
                    print("result is \(result)")
                    
                } catch {
                    return
                }
                */
                print(self.twAccount)
                if let result = try? NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments) as! NSDictionary{
                    print("result is \(result)")
                }
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeLineCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = tweet[indexPath.row]
        return cell
    }
}
