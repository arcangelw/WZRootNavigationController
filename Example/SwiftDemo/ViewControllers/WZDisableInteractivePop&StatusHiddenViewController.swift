//
//  WZDisableInteractivePop&StatusHiddenViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZDisableInteractivePop_StatusHiddenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // disable interactive pop
        // set wz_popEdge = []
        wz_popEdge = []
    }
    
    @IBAction func popSwitch(_ sender: UIBarButtonItem) {
        if wz_popEdge == [] {
           wz_popEdge = .left
           navigationItem.title = "pop on"
           sender.title = "off"
        }else{
           wz_popEdge = []
           navigationItem.title = "pop off"
           sender.title = "on"
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .fade
    }
}
