//
//  WZInteractivePopDisabledViewController.swift
//  WZRootNavigationController_Example_Swift
//
//  Created by 吴哲 on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZInteractivePopDisabledViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wz_interactivePopDisabled = true
        
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
