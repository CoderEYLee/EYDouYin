//
//  EYMessageAAView.swift
//  EYDouYin
//
//  Created by 李二洋 on 2020/5/22.
//  Copyright © 2020 李二洋. All rights reserved.
//

import UIKit
import JTAppleCalendar

private let EYMessageAAViewCellId = "EYMessageAAViewCellId"

private let EYMessageAAViewViewId = "EYMessageAAViewViewId"

private let startDate = Date(timeIntervalSince1970: 1_589_904_000)

open class EYMessageAAView: UIView {

    lazy var monthView : JTACMonthView = {
        let monthView = JTACMonthView(frame: self.frame)
        monthView.ibCalendarDataSource = self
        monthView.ibCalendarDelegate = self
        monthView.register(EYJTACDayCell.self, forCellWithReuseIdentifier: EYMessageAAViewCellId)
        monthView.register(JTACMonthReusableView.self, forSupplementaryViewOfKind: "", withReuseIdentifier: EYMessageAAViewViewId)
        return monthView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(monthView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EYMessageAAView: JTACMonthViewDataSource {
    public func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: startDate, endDate: Date(), hasStrictBoundaries: true)
    }
}

// MARK : JTAppleCalendarDelegate
extension EYMessageAAView: JTACMonthViewDelegate {
    public func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        print("将会渲染");
        //(cell as? CellView)?.setupCellBeforeDisplay(cellState, date: date)
    }
    
    public func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        print("渲染cell");
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: EYMessageAAViewCellId, for: indexPath) as! EYJTACDayCell
        cell.cellState = cellState
        return cell
    }
    
    public func calendar(_ calendar: JTACMonthView, didHighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("已经高亮");
    }
    
    public func calendar(_ calendar: JTACMonthView, didUnhighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("已经取消高亮");
    }
    
    public func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        let timeIntervalStart = date.timeIntervalSince(startDate)
        let timeIntervalEnd = Date().timeIntervalSince(date)
        
        return (timeIntervalStart >= 0.0 && timeIntervalEnd >= 0.0)
    }
    
    public func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("已经选中");
        calendar.reloadItems(at: [indexPath])
    }
    
    public func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        print("将会取消选中");
        return true
    }
    
    public func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("已经取消选中");
    }

    public func calendarDidScroll(_ calendar: JTACMonthView) {
        print("正在滚动");
    }
    
    
    public func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: EYScreenWidth / 7.0)
    }
    
    public func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        print("已经滚动到日期 \(DateSegmentInfo.self)");
    }

    public func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let headerView = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: EYMessageAAViewViewId, for: indexPath)
        return headerView
    }
    
//
//    func calendar(_ calendar: JTAppleCalendarView,
//        sectionHeaderIdentifierFor range: (start: Date, end: Date),
//        belongingTo month: Int) -> String {
//            if month % 2 > 0 {
//                return "WhiteSectionHeaderView"
//            }
//            return "PinkSectionHeaderView"
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
//        if month % 2 > 0 {
//            return CGSize(width: 200, height: 50)
//        } else {
//            // Yes you can have different size headers
//            return CGSize(width: 200, height: 100)
//        }
//    }
//
//    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
//        switch identifier {
//        case "WhiteSectionHeaderView":
//            let headerCell = header as? WhiteSectionHeaderView
//            headerCell?.title.text = "Design multiple headers"
//        default:
//            let headerCell = header as? PinkSectionHeaderView
//            headerCell?.title.text = "In any color or size you want"
//        }
//    }

}

