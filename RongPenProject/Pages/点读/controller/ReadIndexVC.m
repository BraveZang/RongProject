//
//  readIndexVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "ReadIndexVC.h"
#import "LoginVC.h"

@interface ReadIndexVC ()

@end

@implementation ReadIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
      UIButton*textBtn=[UIButton buttonWithType:UIButtonTypeCustom];
      [textBtn setTitle:@"测试跳转到登录" forState:UIControlStateNormal];
      textBtn.frame=CGRectMake(10, 200, ScreenWidth-20, 30);
      [textBtn setBackgroundColor:[UIColor redColor]];
      [self.view addSubview:textBtn];
      [textBtn addTarget:self action:@selector(textBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
}
-(void)textBtnClick{
    
    LoginVC*vc=[[LoginVC alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
