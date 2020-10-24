//
//  WebViewViewController.m
//  SanMuZhuangXiu
//
//  Created by 犇犇网络 on 2018/12/25.
//  Copyright © 2018 Darius. All rights reserved.
//

#import "WebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ViewBackgroundColor;
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=self.titleStr;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)];
    self.webView.delegate=self;
    /* 加载服务器url的方法*/
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)setUrlStr:(NSString *)urlStr{
    
    _urlStr=urlStr;
    _urlStr = [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr=titleStr;
    //    [self setTitle:_titleStr];
    
}
@end
