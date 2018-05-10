//
//  WZCustomNavigationBarViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZCustomNavigationBarViewController: UITableViewController {

    override var wz_navigationBarClass: UINavigationBar.Type? {
        get { return super.wz_navigationBarClass ?? WZCustomNavigationBar.self }
        set {super.wz_navigationBarClass = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.contentView.backgroundColor = UIColor.randomColor
        return cell
    }
    
}
