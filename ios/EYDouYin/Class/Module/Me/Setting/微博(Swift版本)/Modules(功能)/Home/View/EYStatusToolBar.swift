//
//  EYStatusToolBar.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

class EYStatusToolBar: UIView {
    
    var viewModel: EYStatusViewModel? {
        didSet {
            retweetedButton.setTitle(viewModel?.retweetedStr, for: [])
            commentButton.setTitle(viewModel?.commentStr, for: [])
            likeButton.setTitle(viewModel?.likeStr, for: [])
        }
    }
    
    /// 转发
    @IBOutlet weak var retweetedButton: UIButton!
    /// 评论
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞
    @IBOutlet weak var likeButton: UIButton!
}
