//
//  AppDelegate.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "DZBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZBaseWebViewController : DZBaseViewController

@property (nonatomic, strong) UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end

NS_ASSUME_NONNULL_END
