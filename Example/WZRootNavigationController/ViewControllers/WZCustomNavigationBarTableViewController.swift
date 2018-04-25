//
//  WZCustomNavigationBarTableViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZCustomNavigationBarTableViewController: UITableViewController {

    override var wz_navigationBarClass: UINavigationBar.Type?
    {
        return WZCustomNavigationBar.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.hidesBarsOnSwipe = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableView+customNavgationBar", for: indexPath)

        cell.textLabel?.text = "cell sections:\(indexPath.section)  row:\(indexPath.row)"

        return cell
    }
 

}
