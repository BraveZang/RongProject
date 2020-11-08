//
//  ConnectPenResultVC.m
//  RongPenProject
//
//  Created by mac on 7.11.20.
//

#import "ConnectPenResultVC.h"

@interface ConnectPenResultVC ()
@property (nonatomic, strong)UILabel         *successLab;
@property (nonatomic, strong)UIImageView    *IconImgV;
@property (nonatomic, strong)UILabel         *macLab;
@property (nonatomic, strong)UIButton       *footerBtn;
@end

@implementation ConnectPenResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.leftImgBtn.hidden=NO;
    self.toptitle.text=@"连接蓝牙笔";
    self.view.backgroundColor = hexColor(F3F5F8);
    [self.view addSubview:self.IconImgV];
    [self.view addSubview:self.successLab];
    [self.view addSubview:self.macLab];
    [self.view addSubview:self.footerBtn];
}

#pragma mark -lazy


- (UIImageView *)IconImgV{
    if (!_IconImgV) {
        _IconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH_6S(143.0), SafeAreaTopHeight + 116, APP_WIDTH_6S(88.0), APP_WIDTH_6S(88.0))];
        _IconImgV.image =[UIImage imageNamed:@"pen_success"];
    }
    return _IconImgV;
}

- (UILabel *)successLab{
    if (!_successLab) {
        _successLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.IconImgV.bottom + 25, SCREEN_WIDTH, APP_WIDTH_6S(25.0))];
        _successLab.textColor = hexColor(212121);
        _successLab.textAlignment = NSTextAlignmentCenter;
        _successLab.font = [UIFont systemFontOfSize:22];
        _successLab.text = @"连接成功";
    }
    return _successLab;
}

- (UILabel *)macLab{
    if (!_macLab) {
        _macLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.successLab.bottom + 15, SCREEN_WIDTH, APP_WIDTH_6S(20.0))];
        _macLab.textColor = hexColor(212121);
        _macLab.textAlignment = NSTextAlignmentCenter;
        _macLab.font = [UIFont systemFontOfSize:16];
        _macLab.text = @"12:89:103:1231";
    }
    return _macLab;
}

- (UIButton *)footerBtn{
    
    if (!_footerBtn) {
        _footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _footerBtn.frame = CGRectMake((ScreenWidth-200)/2, KSCREEN_HEIGHT - 160, 200, 40);
        [_footerBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerBtn setBackgroundImage:[UIImage imageNamed:@"chakanBtn"] forState:UIControlStateNormal];
        [_footerBtn setTitle:@"确定" forState:UIControlStateNormal];
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
