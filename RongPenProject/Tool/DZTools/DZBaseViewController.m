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
    self.rightImgBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.rightImgBtn];
    
    self.toptitle=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-240)/2, SafeAreaTopHeight-64+(64-15)/2, 240, 30)];
    self.toptitle.font=[UIFont boldSystemFontOfSize:14];
    self.toptitle.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.toptitle];
    self.toptitle.hidden=YES;
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
