//
//  ViewController.swift
//  WZRootNavigationController
//
//  Created by arcangelw on 04/20/2018.
//  Copyright (c) 2018 arcangelw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "first"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


   @IBAction func popToRoot(_ segue:UIStoryboardSegue){
    print(self.classForCoder , #function ,":",segue.identifier ?? "")
   }

}

