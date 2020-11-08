//
//  ConnectPenGuideVC.m
//  RongPenProject
//
//  Created by mac on 7.11.20.
//

#import "ConnectPenGuideVC.h"
#import "PenGuideView.h"
#import "ConnectPenVC.h"
@interface ConnectPenGuideVC ()

@property (nonatomic, strong)PenGuideView   *headerView;
@property (nonatomic, strong)UIImageView    *IconImgV;
@property (nonatomic, strong)UIButton       *footerBtn;

@end

@implementation ConnectPenGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.toptitle.text=@"连接蓝牙笔";
    self.view.backgroundColor = hexColor(F3F5F8);
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.IconImgV];
    [self.view addSubview:self.footerBtn];

}

- (void)nextClick{
    ConnectPenVC * target = [[ConnectPenVC alloc] init];
    [self.navigationController pushViewController:target animated:YES];
}


#pragma mark -- lazy

- (PenGuideView *)headerView {
    if (!_headerView) {
        _headerView = [[PenGuideView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, 111)];
        
    }
    return _headerView;
}

- (UIImageView *)IconImgV{
    if (!_IconImgV) {
        _IconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(15.0), self.headerView.bottom +10, APP_WIDTH_6S(345.0), APP_WIDTH_6S(345.0))];
        _IconImgV.image =[UIImage imageNamed:@"pen_guide"];
        
    }
    return _IconImgV;
}

- (UIButton *)footerBtn{
    
    if (!_footerBtn) {
        _footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _footerBtn.frame = CGRectMake((ScreenWidth-200)/2, self.IconImgV.bottom +60, 200, 40);
        [_footerBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerBtn setBackgroundImage:[UIImage imageNamed:@"chakanBtn"] forState:UIControlStateNormal];
        [_footerBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _footerBtn;
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
