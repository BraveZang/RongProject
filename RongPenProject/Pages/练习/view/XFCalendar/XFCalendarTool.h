//
//  XFCalendarTool.h
//  Calendar
//
//  Created by XiaoFeng on 2016/11/22.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFCalendarTool : NSObject

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;

@end
