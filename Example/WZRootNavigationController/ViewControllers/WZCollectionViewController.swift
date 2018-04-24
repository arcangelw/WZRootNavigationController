//
//  WZCollectionViewController.swift
//  WZRootNavigationController
//
//  Created by wu.zhe on 2018/4/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionView-Horizontal"

class WZCollectionViewHorizontalCell: UICollectionViewCell {
    
    var label: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubview()
    }

    func setupSubview() {
        contentView.backgroundColor = .green
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label":label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label":label]))
    }
}

class WZCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.label.text = "item : \(indexPath.item)"
        return cell
    }
}
