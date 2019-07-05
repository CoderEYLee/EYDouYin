//
//  EYProfileCell.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/19.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

class EYProfileCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel?

    @IBOutlet weak var rightImageView: UIImageView?


    var viewModel: EYProfileViewModel? {
        didSet {
           tipLabel?.text = viewModel?.tipString
            detailLabel?.text = viewModel?.fileSizeString
            rightImageView?.image = viewModel?.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
