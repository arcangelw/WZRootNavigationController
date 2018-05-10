//
//  WZRootTableViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController

class WZRootTableViewController: UITableViewController {
    
    @IBAction func swiftToRoot(withSegue segue:UIStoryboardSegue){
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath),indexPath.section == 0 ,indexPath.row > 0 else {
            return
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WZCustomAnimationListViewController")
        switch indexPath.row {
        case 1:
            vc.wz_animationProcessing = WZRootTransitionAnimationProcess(type: .omniFocus(keyView: cell.contentView))
            break
        case 2:
            vc.wz_animationProcessing = WZRootTransitionAnimationProcess.page
            break
        case 3:
            vc.wz_animationProcessing = WZRootTransitionAnimationProcess.fadeOut
            break
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
