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

open class EYJTCalendarView: UIView {
    
    ///选中的日期
    var selectedDate = Date()
    
    ///今天的日期
    var today = Date()
    
    let dateFormatter = DateFormatter()
    
    var inDay = 1
    var inMonth = 1
    var inYear = 1970

    lazy var monthView : JTACMonthView = {
        let monthView = JTACMonthView(frame: CGRect(origin: .zero, size: frame.size))
        monthView.backgroundColor = EYRGBColor(r: 255, g: 255, b: 255)
        //滚动方向:水平
        monthView.scrollDirection = .horizontal
        //按照月滚动
        monthView.scrollingMode = ScrollingMode.stopAtEachCalendarFrame
        monthView.isPagingEnabled = true
        //设置日历的一些基本格式，这里我们把所有的空全部去除
        monthView.minimumLineSpacing = 0
        monthView.minimumInteritemSpacing = 0
        monthView.ibCalendarDataSource = self
        monthView.ibCalendarDelegate = self
        monthView.register(EYJTACDayCell.self, forCellWithReuseIdentifier: EYMessageAAViewCellId)
        monthView.register(JTACMonthReusableView.self, forSupplementaryViewOfKind: "", withReuseIdentifier: EYMessageAAViewViewId)
        return monthView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(monthView)
        
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let strs = dateFormatter.string(from: today).split(separator: " ")
        inMonth = Int(strs[1])!
        inYear = Int(strs[0])!
        
        //设置完毕之后默认初始选中日期是当天
        backToday()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //返回当天
    @discardableResult
    func backToday() -> Bool {
        today = Date()
        
        var ret = false
        if dateFormatter.string(from: today) == dateFormatter.string(from: selectedDate) {
            ret = false
        } else {
            ret = true
        }
        //在这里只需要设置selectDates就会自动调用后面的didSelectedDate的delegate，建议在完成滚动之后再设置，否则容易出现cell被回收的问题
        monthView.scrollToDate(today, triggerScrollToDateDelegate: true, animateScroll: true, completionHandler: {
            self.monthView.selectDates([self.today])
            self.selectedDate = self.today
            //如果不放心可以调用下面这个函数重置所有的格子状态
            //self.monthView.reloadData() //failsafe solution to avoid nil cell deselect
        })
        return ret
    }
    
    func isThisMonth(date:Date) -> Int64 {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let month = Int(formatter.string(from: date))
        formatter.dateFormat = "yyyy"
        let year = Int(formatter.string(from: date))
        if year! > inYear {
            return 1 //next month
        } else if year! < inYear {
            return -1 //previous month
        } else {
            if month! < inMonth {
                return -1
            } else if month! > inMonth {
                return 1
            } else {
                return 0
            }
        }
    }
}

extension EYJTCalendarView: JTACMonthViewDataSource {
    public func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2000 05 20") ?? Date()
        let endDate = Date()
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate, hasStrictBoundaries: true)
    }
}

// MARK : JTAppleCalendarDelegate
extension EYJTCalendarView: JTACMonthViewDelegate {
    public func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! EYJTACDayCell
        cell.cellState = cellState
        print("将会渲染");
    }
    
    public func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2000 05 20") ?? Date()
        
        let timeIntervalStart = date.timeIntervalSince(startDate)
        let timeIntervalEnd = Date().timeIntervalSince(date)
        
        return (timeIntervalStart >= 0.0 && timeIntervalEnd >= 0.0)
    }
    
    public func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        selectedDate = date

        //下面的代码判断是否选中了其他月份的日期，并自动滑动
        let res = isThisMonth(date: date)
        if res == 1 {
            calendar.scrollToSegment(SegmentDestination.next)
            EYLog("下个月")
        } else if res == -1 {
            calendar.scrollToSegment(SegmentDestination.previous)
            EYLog("上个月")
        }
        
        let cell = cell as? EYJTACDayCell
        if cell != nil {
            //这里需要手动更新cell的view状态
//            if (dateCell?.isMarked)! && delegate != nil {
//                delegate?.onToMarkDate(date: date)
//            }
        }

//        if delegate != nil {
//            delegate?.onToDate(date: date)
//        }
        calendar.reloadItems(at: [indexPath])
        print("已经选中");
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
        let inDate = visibleDates.monthDates[0].date
        let str = dateFormatter.string(from: inDate)
        let strs = str.split(separator: " ")
        let year = Int(strs[0])!
        let month = Int(strs[1])!
        
        if (month != inMonth) {
            inMonth = month
        }
        
        if (year != inYear) {
            inYear = year
        }
    }

    public func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let headerView = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: EYMessageAAViewViewId, for: indexPath)
        headerView.backgroundColor = .green
        return headerView
    }
    
    public func sizeOfDecorationView(indexPath: IndexPath) -> CGRect {
        return .zero
    }
    
    public func scrollDidEndDecelerating(for calendar: JTACMonthView) {
        print("结束滚动")
    }

    public func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        print("qqq")
    }
}
