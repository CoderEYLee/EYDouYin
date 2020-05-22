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
            if cellState?.isSelected ?? false {
                self.backgroundColor = .red
            } else {
                self.backgroundColor = .blue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func draw(_ rect: CGRect) {
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
//        let r1 = CGRect(x: 0, y: 0, width: 25, height: 25)
//        context?.addRect(r1)
//        context?.fillPath()
//        context?.setStrokeColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0)
//        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 25, height: 25))
//        context?.strokePath()
//    }
}
