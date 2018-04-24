//
//  WZPopAllowedEdgeCollectionViewController.swift
//  WZRootNavigationController_Example_Swift
//
//  Created by 吴哲 on 2018/4/24.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionView-Horizontal"

class WZPopAllowedEdgeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///cell 宽度 60 leftspacing 10 验证在第一列pop手势有效性
        self.wz_interactivePopAllowedEdge = UIEdgeInsetsMake(0.0, 70.0, 0.0, 0.0)
    }

    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WZCollectionViewHorizontalCell
        cell.contentView.backgroundColor = .yellow
        cell.label.text = "item : \(indexPath.item)"
        return cell
    }

}
