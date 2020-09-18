//
//  BLELog.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DLog(format, ...) CustomLog(__FUNCTION__,__LINE__,format,##__VA_ARGS__)
void CustomLog(const char *func, int lineNumber, NSString *format, ...);
@interface BLELog : NSObject
+ (void)setLogEnable:(BOOL)flag;
+ (BOOL)logEnable;

@end
