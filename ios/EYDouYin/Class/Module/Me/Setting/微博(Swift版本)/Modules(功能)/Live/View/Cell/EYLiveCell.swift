//
//  EYLiveCell.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/22.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import SDWebImage

class EYLiveCell: UITableViewCell {

    // 头像
    @IBOutlet weak var headImageView: UIImageView!

    // 名称
    @IBOutlet weak var nickNameLabel: UILabel!

    // 地址
    @IBOutlet weak var addressLabel: UILabel!

    // 观看数量
    @IBOutlet weak var viewersLabel: UILabel!

    // 直播截图
    @IBOutlet weak var shotImageView: UIImageView!

    var viewModel: EYLiveViewModel? {
        didSet {
            headImageView.ey_setImage(urlString: viewModel?.live.creator?.portrait, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            nickNameLabel.text = viewModel?.nickName
            addressLabel.text = (viewModel?.address?.isEmpty)! ? "未知星球" :viewModel?.address
            viewersLabel.text = viewModel?.viewers
            shotImageView.ey_setImage(urlString: viewModel?.live.creator?.portrait, placeholderImage: UIImage(named: "avatar_default_big"))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
