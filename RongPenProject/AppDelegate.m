//
//  AppDelegate.m
//  RongPenProject
//
//  Created by zanghui on 2020/9/12.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import "AlipayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMShare/UMShare.h>
#import "TabarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    // AppDelegate 进行全局设置
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
   
    //下面两行代码主要是防止加载大分辨率图片时内存暴涨crash
    [SDImageCache sharedImageCache].config.shouldCacheImagesInMemory = NO;//缓存图片不放入内存
      //sd中可点击diskCacheReadingOptions跳转到这个属性，提示设置为NSDataReadingMappedIfSafe可提高性能
    [SDImageCache sharedImageCache].config.diskCacheReadingOptions = NSDataReadingMappedIfSafe;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    TabarVC *vc=[[TabarVC alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    

    
    return YES;
}

#pragma mark - 生命周期
- (void)applicationWillEnterForeground:(UIApplication *)application{
    NSLog(@"状态** 将要进入前台");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginBackVideo" object:nil];


}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"状态** 已经活跃");
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginBackVideo" object:nil];

}
- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"状态** 将要进入后台");

}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"状态** 已经进入后台");
}
- (void)applicationWillTerminate:(UIApplication *)application{
    NSLog(@"状态** 将要退出程序");
    [[PenCommAgent getInstance]transferOfflineData:NO];

}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {


        if ([url.host isEqualToString:@"safepay"]) {
           //  支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                      standbyCallback:^(NSDictionary *resultDic) {
                                                          NSLog(@"result = %@", resultDic);
                                [[AlipayManager sharedManager] managerStandbyCallback:resultDic];

                                                      }];

//             授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url
                                             standbyCallback:^(NSDictionary *resultDic) {
                                                 NSLog(@"result = %@", resultDic);
                                [[AlipayManager sharedManager] processAuthStandbyCallback:resultDic];


                                             }];
        }
    }
    return result;
}


@end
