//
//  AlipayManager.m
//  SanMuZhuangXiu
//
//  Created by 王巧云 on 2019/5/27.
//  Copyright © 2019 Darius. All rights reserved.
//

#import "AlipayManager.h"

@implementation AlipayManager
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static AlipayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[AlipayManager alloc] init];
    });
    return instance;
}
- (void)managerStandbyCallback:(NSDictionary *)resultDic{
    if ([resultDic[@"resultStatus"] intValue] == 9000) {
        [DZTools showOKHud:@"支付完成" delay:2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zhifuSuccess" object:nil];
    } else if ([resultDic[@"resultStatus"] intValue] == 6001) {
        [DZTools showNOHud:@"支付取消" delay:2];
        
    } else {
        [DZTools showNOHud:@"支付失败" delay:2];
    }
    
    
}
- (void)processAuthStandbyCallback:(NSDictionary *)resultDic{
    NSString *result = resultDic[@"result"];
    NSString *authCode = nil;
    if (result.length > 0) {
        NSArray *resultArr = [result componentsSeparatedByString:@"&"];
        for (NSString *subResult in resultArr) {
            if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                authCode = [subResult substringFromIndex:10];
                break;
            }
        }
    }
   
}

@end
