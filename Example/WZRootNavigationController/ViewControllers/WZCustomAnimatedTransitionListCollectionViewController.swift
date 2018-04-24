//
//  WZCustomAnimatedTransitionListCollectionViewController.swift
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/24.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WZRootNavigationController
private let reuseIdentifier = "customAnimatedTransitionListCell"

class WZCustomAnimatedTransitionListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class WZCustomAnimatedTransitionListCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override var wz_animatedTransitionPluginClass: WZAnimatedTransitionPlugin.Type{
        return WZCustomAnimatedTransition.self
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WZCustomAnimatedTransitionListCell
        cell.contentView.backgroundColor = .yellow
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            let w:CGFloat = (self.view.frame.width - 10.0 * 4.0) / 3.0
            layout.itemSize = CGSize(width: w, height: w)
            layout.minimumLineSpacing = 9.0
            layout.minimumInteritemSpacing = 9.0
            layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        }
    }
}
