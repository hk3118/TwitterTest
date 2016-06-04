//
//  LoginViewController.swift
//  TwitterTest
//
//  Created by 小林 悠人 on 2016/06/01.
//  Copyright © 2016年 小林 悠人. All rights reserved.
//

import UIKit
import Accounts
import Social

class  LoginViewController: UIViewController {
    
    @IBAction func Login(sender: UIButton){
        getTwitterAccount()
    }
    
    var accountStore = ACAccountStore()
    var twitterAccount : ACAccount?
    
    private func getTwitterAccount(){
        
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil){
            (granted:Bool, error:NSError?) -> Void in
            if error != nil{
                print("error! \(error)")
                return
            }
            
            if !granted {
                print("error! Twitterアカウントの利用が許可されていません")
                return
            }
            
            //Twitterアカウント情報の取得
            let accounts = self.accountStore.accountsWithAccountType(accountType) as! [ACAccount]
            if accounts.count == 0{
                print("error! 設定画面からアカウントを設定してください")
                return
            }
            
            //ActionSheetを表示
            self.selectTwitterAccount(accounts)
        }
    }
    
    private func selectTwitterAccount(accounts: [ACAccount]){
        //ActionSheetのタイトルとメッセージを指定
        let alert = UIAlertController(title: "Twitter",
                                      message: "アカウントを選択してください",
                                      preferredStyle: .ActionSheet)
        
        //取得したアカウント分actionSheetに表示する
        for account in accounts{
            //ボタンの表示
            alert.addAction(UIAlertAction(title: account.username, style: .Default, handler: {
                    (action:UIAlertAction!) -> Void in
                    //タップされた際の挙動
                    print("your select account is \(account)")
                    self.twitterAccount = account
                    self.performSegueWithIdentifier("mySegue", sender: nil)
            }))
        }
        
        //キャンセルボタンの表示
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        //actionSheetの表示
        presentViewController(alert, animated: true, completion: nil)
    }

    //TimeLineViewControllerに
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //もしmySegur のSegueが起動された場合
        if segue.identifier == "mySegue"{
            //もし遷移先がTimeLineViewControllerの場合
            if let vc: TimeLineViewController = segue.destinationViewController as? TimeLineViewController{
                vc.receivedTwitterAccount = twitterAccount
            }
        }
    }
}
