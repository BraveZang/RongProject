//
//  MyCalendarItem.h
//  HYCalendar
//
//  Created by nathan on 14-9-17.
//  Copyright (c) 2014年 nathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFCalendarTool.h"

@interface XFCalendarView : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

@property (nonatomic, copy) void(^calendarBlock1)(NSInteger month, NSInteger year);

@property (nonatomic,strong)  NSMutableArray *signArray;
@property (nonatomic,strong)  NSDate *currentDate;

//今天
@property (nonatomic,strong)  UIButton *dayButton;


- (void)setStyle_Today_Signed:(UIButton *)btn;
- (void)setStyle_Today:(UIButton *)btn;
- (void)setupRequestMonth;
@end
