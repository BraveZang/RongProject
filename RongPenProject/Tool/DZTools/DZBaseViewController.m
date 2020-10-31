//
//  AppDelegate.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "DZBaseViewController.h"

@interface DZBaseViewController ()

@end

@implementation DZBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SafeAreaTopHeight)];
    self.topview.backgroundColor=[UIColor whiteColor];
    self.topview.hidden=YES;
    [self.view addSubview:self.topview];
    
    self.image = [UIImage imageNamed:@"back"];
    self.image = [ self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage: self.image  style:UIBarButtonItemStyleDone target:self action:@selector(backItemClicked)];
    
    self.lineview=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight-1, ScreenWidth, 1)];
    self.lineview.backgroundColor=LINECOLOR;
    self.lineview.hidden=YES;
    [self.view addSubview:self.lineview];
    
    self.leftImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftImgBtn.frame=CGRectMake(10, SafeAreaTopHeight-64+(64-15)/2, 45, 30);
    [self.leftImgBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.leftImgBtn.hidden=YES;
    self.leftImgBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.leftImgBtn addTarget:self action:@selector(backItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftImgBtn];
    
    self.rightImgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightImgBtn.frame=CGRectMake(ScreenWidth-65-10, SafeAreaTopHeight-64+(64-15)/2, 65, 30);
    self.rightImgBtn.hidden=YES;
    [self.rightImgBtn setImage:[UIImage imageNamed:@"rightImg"] forState:UIControlStateNormal];
    self.rightImgBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.rightImgBtn];
    
    self.toptitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-240)/2, SafeAreaTopHeight-64+(64-15)/2, 240, 30)];
    self.toptitle.font=[UIFont boldSystemFontOfSize:14];
    self.toptitle.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.toptitle];
    self.toptitle.hidden=YES;
    
    //无数据时候的显示
    self.noDataView=[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaTopHeight-SafeAreaBottomHeight-300*SCREEN_WIDTH/750)];
    self.noDataView.backgroundColor=[UIColor whiteColor];
    self.noDataImage=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-136*SCREEN_WIDTH/750)/2, 300*SCREEN_WIDTH/750, 136*SCREEN_WIDTH/750, 150*SCREEN_WIDTH/750)];
    [self.noDataImage setImage:[UIImage imageNamed:@"JYH_nodataimg"]];
    [self.noDataView addSubview: self.noDataImage];
    
    self.noDataLab=[MTool quickCreateLabelWithleft:0 top:self.noDataView.bottom-200 width:SCREEN_WIDTH heigh:50*SCREEN_WIDTH/750 title:@"该条件下没有任何信息"];
    self.noDataLab.textAlignment=NSTextAlignmentCenter;
    self.noDataLab.font=[UIFont systemFontOfSize:14];
    self.noDataLab.textColor=[MTool colorWithHexString:@"999999"];
    [ self.noDataView addSubview:self.noDataLab];
}
- (void)backItemClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
