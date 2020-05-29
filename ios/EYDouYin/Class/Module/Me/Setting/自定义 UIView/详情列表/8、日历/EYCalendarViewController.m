//
//  EYCalendarViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/5/30.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "EYCalendarViewController.h"

@interface EYCalendarViewController () <FSCalendarDataSource, FSCalendarDelegate>

@property (weak , nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;

@end

@implementation EYCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = EYColorRandom;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenWidth)];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    calendar.dataSource = self;
    calendar.delegate = self;
    [calendar registerClass:FSCalendarCell.class forCellReuseIdentifier:@"EYCalendarViewControllerCellID"];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
}

#pragma mark - FSCalendarDataSource
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
    NSInteger day = [self.gregorian component:NSCalendarUnitDay fromDate:date];
    return [NSString stringWithFormat:@"%ld", day];
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(nonnull NSDate *)date {
    return nil;
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date {
    return nil;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate dateWithTimeIntervalSinceNow:- 60 * 60 * 24 * 365];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate date];
}

- (__kindof FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
    FSCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"EYCalendarViewControllerCellID" forDate:date atMonthPosition:position];
    cell.backgroundColor = EYColorRandom;
    return cell;
}


- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {//cell底部的圆点
    return 0;
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    EYLog(@"shouldSelectDate");
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    EYLog(@"didSelectDate");
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    EYLog(@"shouldDeselectDate");
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    EYLog(@"didDeselectDate");
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    EYLog(@"boundingRectWillChange");
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    EYLog(@"willDisplayCell");
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
    EYLog(@"calendarCurrentPageDidChange");
}


@end
