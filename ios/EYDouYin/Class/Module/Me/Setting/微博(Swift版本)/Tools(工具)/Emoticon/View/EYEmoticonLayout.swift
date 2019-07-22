//
//  EYEmoticonLayout.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

/// 表情集合视图的布局
class EYEmoticonLayout: UICollectionViewFlowLayout {

    /// prepare 就是 OC 中的 prepareLayout
    override func prepare() {
        super.prepare()
        
        // 在此方法中，collectionView 的大小已经确定
        guard let collectionView = collectionView else {
            return
        }
        
        itemSize = collectionView.bounds.size
        
        // 设定滚动方向
        // 水平方向滚动，cell 垂直方向布局
        // 垂直方向滚动，cell 水平方向布局
        scrollDirection = .horizontal
    }
}
