//
//  EYJTACDayCell.swift
//  EYDouYin
//
//  Created by 李二洋 on 2020/5/22.
//  Copyright © 2020 李二洋. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SnapKit

class EYJTACDayCell: JTACDayCell {
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var cellState: CellState? {
        didSet {
            dateLabel.text = cellState?.text
            
            if cellState?.dateBelongsTo == .thisMonth {
                dateLabel.textColor = .black
            } else {
                dateLabel.textColor = .gray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
