//
//  ThirdViewController.swift
//  WZRootNavigationController_Example
//
//  Created by wu.zhe on 2018/4/22.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    deinit {
        print(self.classForCoder, #line , #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "third"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
