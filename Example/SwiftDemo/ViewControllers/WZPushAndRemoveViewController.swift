//
//  WZPushAndRemoveViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController
class WZPushAndRemoveViewController: UIViewController {
    
    @IBOutlet weak var isAnimatedSwitch: UISwitch!
    
    @IBAction func pushAndRemove(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WZHorizontalScrollViewController")
        wz_navigationController?.pushViewController(vc, animated: isAnimatedSwitch.isOn, completion: { _ in
            self.wz_navigationController?.remove(viewController: self)
        })
    }

}
