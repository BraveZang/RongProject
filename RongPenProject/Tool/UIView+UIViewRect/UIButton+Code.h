//
//  UIButton+Code.h
//  UIButton+SVCode
//
//  Created by Mr_qing on 2017/7/16.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Code)
//setCountdownTime
///设置倒计时
- (void)setCountdown:(NSTimeInterval )timeOut WithStartString:(NSString *)startStr WithEndString:(NSString *)endStr;
///设置活动倒计时
- (void)setCountdownTime:(NSTimeInterval )timeOut WithStartString:(NSString *)startStr WithEndString:(NSString *)endStr;
///手动结束倒计时 离开页面之前 请务必调用
- (void)cancelCountdownWithEndString:(NSString *)endStr;

@end
