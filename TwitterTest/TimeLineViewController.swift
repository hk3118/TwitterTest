//
//  TimeLineViewController.swift
//  TwitterTest
//
//  Created by 小林 悠人 on 2016/05/31.
//  Copyright © 2016年 小林 悠人. All rights reserved.
//

import UIKit
import Accounts
import Social


class TimeLineViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var TableView: UITableView!
    
    /* private let dataSource: TimeLineDataSource = TimeLineDataSource() */
    private let dataSource = TimeLineDataSource()
    
    //LoginViewControllerからログインしたアカウントの情報の受け口
    var receivedTwitterAccount: ACAccount?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self.dataSource
        dataSource.twAccount = receivedTwitterAccount
        
        dataSource.getTweet()
        TableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

