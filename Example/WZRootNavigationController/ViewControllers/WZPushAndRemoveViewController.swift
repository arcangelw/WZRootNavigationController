//
//  WZPushAndRemoveViewController.swift
//  WZRootNavigationController_Example_Swift
//
//  Created by 吴哲 on 2018/4/24.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WZPushAndRemoveViewController: UIViewController {

    @IBOutlet weak var animatingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func pushAndRemove(_ sender: Any) {
        let normal = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WZNormalViewController")
        self.wz_navigationController?.pushViewController(normal, animated: self.animatingSwitch.isOn, completion: {[weak self] in
            guard let `self` = self else { return }
            if $0 {
                self.wz_navigationController?.remove(viewController: self)
            }
        })
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
