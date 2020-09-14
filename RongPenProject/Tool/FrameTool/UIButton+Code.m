//
//  UIButton+Code.m
//  UIButton+SVCode
//
//  Created by Mr_qing on 2017/7/16.
//  Copyright © 2017年 jonh. All rights reserved.
//

#import "UIButton+Code.h"

static dispatch_source_t _timer;
@implementation UIButton (Code)

- (void)setCountdown:(NSTimeInterval )timeOut WithStartString:(NSString *)startStr WithEndString:(NSString *)endStr{
    __block int timeout=timeOut;
    //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            [self cancelCountdownWithEndString:endStr];
            
        }else{
            
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@s%@",strTime,startStr] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)setCountdownTime:(NSTimeInterval )timeOut WithStartString:(NSString *)startStr WithEndString:(NSString *)endStr{
    __block int timeout=timeOut;
    //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            [self cancelCountdownWithEndString:endStr];
            
        }else{
            
            NSInteger days = (int)(timeout/(3600*24));
            NSInteger hours = (int)((timeout-days*24*3600)/3600);
            NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
            NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
            
            NSString *strTime = [NSString stringWithFormat:@"剩余: %02ld : %02ld : %02ld", hours, minute, second];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:strTime forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)cancelCountdownWithEndString:(NSString *)endStr
{
    if(_timer)
    {
        
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）
             [self setTitle:endStr forState:UIControlStateNormal];
             self.userInteractionEnabled = YES;
            
        });
    }
}

@end
