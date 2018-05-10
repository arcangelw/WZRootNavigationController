//
//  WZPopAllowedEdgeViewController.swift
//  SwiftDemo
//
//  Created by 吴哲 on 2018/5/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class WZPopAllowedEdgeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // left 设置一个cell宽度 + 边距
        let w:CGFloat = (self.view.frame.width - 10.0 * 6.0) / 5.0 + 10.0
        wz_popAllowedEdge = UIEdgeInsets(top: 0.0, left: w, bottom: 0.0, right: 0.0)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WZCustomAnimatedListCell
        cell.imageView.backgroundColor = UIColor.randomColor
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            let w:CGFloat = (self.view.frame.width - 10.0 * 6.0) / 5.0
            layout.itemSize = CGSize(width: w, height: w)
            layout.minimumLineSpacing = 9.0
            layout.minimumInteritemSpacing = 9.0
            layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        }
    }
}
