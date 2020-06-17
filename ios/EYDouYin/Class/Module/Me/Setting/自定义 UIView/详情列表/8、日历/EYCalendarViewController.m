//
//  EYCalendarViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/5/30.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "EYCalendarViewController.h"

#define EYCalendarViewControllerStartDate 1589904000

@interface EYCalendarViewController () <FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>

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
    calendar.backgroundColor = EYColorWhite;
    calendar.appearance.headerDateFormat = @"";
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
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
    return [NSDate dateWithTimeIntervalSince1970:1589904000];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate date];
}

- (__kindof FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
    FSCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"EYCalendarViewControllerCellID" forDate:date atMonthPosition:position];
    return cell;
}


- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {//cell底部的圆点
    return 0;
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSTimeInterval timeInterval = date.timeIntervalSince1970;
    NSTimeInterval end = [NSDate date].timeIntervalSince1970;
    if (EYCalendarViewControllerStartDate <= timeInterval && timeInterval <= end) {
        return YES;
    }
    return NO;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
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

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {//将会渲染 cell
    
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {//滑动了一个月
    
}

#pragma mark - FSCalendarDelegateAppearance
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    return calendar.backgroundColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date {
    return EYColorRGBHexAlpha(0xFEC202, 0.2);
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    return EYColorRGBHex(0x21242B);
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date {
    return EYColorRGBHex(0x21242B);
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date {
    return calendar.backgroundColor;
}


- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(NSDate *)date {
    return calendar.backgroundColor;
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date {
    return nil;
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventSelectionColorsForDate:(NSDate *)date {
    return nil;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date {
    return calendar.backgroundColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date {
    return calendar.backgroundColor;
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleOffsetForDate:(NSDate *)date {
    return CGPointMake(0, 2);
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleOffsetForDate:(NSDate *)date {
    return CGPointZero;
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance imageOffsetForDate:(NSDate *)date {
    return CGPointZero;
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventOffsetForDate:(NSDate *)date {
    return CGPointMake(0, 2);
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(NSDate *)date {
    return 15;
}

@end
