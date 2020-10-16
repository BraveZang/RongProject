//
//  LoginVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "LoginVC.h"
#import "UIButton+Code.h"
#import "forgetPassVC.h"
#import "WebViewViewController.h"

typedef enum : NSUInteger{
    Accountlogin,//账号登录
    Accountsmscaptcha,//获取验证码
    Accountsmslogin,//验证码登录
     
}requestIdEnum;

@interface LoginVC ()<UITextFieldDelegate,NetManagerDelegate>

@property (strong,nonatomic)   UITextField                  *codeTexF;
@property (strong,nonatomic)   UITextField                  *passTexF;
@property (strong,nonatomic)   UITextField                  *nameTexF;
@property (strong,nonatomic)   UIButton                     *codeButton;
@property (strong,nonatomic)   UIView                       *codeView;
@property (strong,nonatomic)   UIButton                     *loginBtn;
@property (strong,nonatomic)   UIButton                     *youkeBtn;
@property (strong,nonatomic)   UIButton                     *bottomBtn;
@property (strong,nonatomic)   UIButton                     *forgetPassBtn;


@property (nonatomic,strong)   NetManager                   *net;
@property (strong,nonatomic)   UIButton                     *typeButton;
@property (strong,nonatomic)   UIButton                     *agreeButton;
@property (strong,nonatomic)   UIButton                     *agreeButton1;
@property (strong,nonatomic)   UILabel                      *bottomLab;
@property (strong,nonatomic)   UILabel                      *bigTitle;
@property (strong,nonatomic)   UILabel                      *smallTitle;

@property (strong, nonatomic)  NSString                     *nickname;
@property (nonatomic, strong)  UITextView                   *tv_result;
@property (nonatomic, strong)  UITextField                  *tf_timeout;
@property (nonatomic, assign)  NSInteger                    loginType;//0 账号密码  1手机登录
@property (nonatomic, strong)  NSString                     *passWorldStr;

@end

@implementation LoginVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.leftImgBtn.hidden=NO;
    [self.leftImgBtn setImage:[UIImage imageNamed:@"close_login"] forState:UIControlStateNormal];
    self.loginType=0;
    self.nameTexF.delegate=self;
    self.passTexF.delegate=self;
    self.codeTexF.delegate=self;
    
    [self createUI];
    [self.view addSubview:self.leftImgBtn];

}

- (void)pop{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)createUI{
    
    UIView*bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgview.backgroundColor=[UIColor blackColor];
    bgview.alpha=0.5;
    
    UILabel*bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, FitRealValue(144), ScreenWidth-40, FitRealValue(48))];
    bigTitle.text=@"欢迎使用点读产品";
    bigTitle.font=[UIFont boldSystemFontOfSize:24];
    bigTitle.textColor=[MTool colorWithHexString:@"#212121"];
    self.bigTitle=bigTitle;
    [self.view addSubview:self.bigTitle];
    
    UILabel*smallTitle=[[UILabel alloc]initWithFrame:CGRectMake(20,bigTitle.bottom+FitRealValue(20), ScreenWidth-40, FitRealValue(24))];
    smallTitle.text=@"未注册过的手机号将自动创建账号";
    smallTitle.font=[UIFont systemFontOfSize:12];
    smallTitle.textColor=[MTool colorWithHexString:@"#4E4E4E"];
    self.smallTitle=smallTitle;
    [self.view addSubview:self.smallTitle];
    
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView1.backgroundColor=[UIColor clearColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView2.backgroundColor=[UIColor clearColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView3.backgroundColor=[UIColor clearColor];
    
    
    self.nameTexF=[[UITextField alloc]initWithFrame:CGRectMake(30, smallTitle.bottom+FitRealValue(104), ScreenWidth-60, 44)];
    self.nameTexF.delegate=self;
    self.nameTexF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTexF.leftView = leftView1;
    self.nameTexF.backgroundColor=[UIColor whiteColor];
    self.nameTexF.placeholder=@"手机号";
    self.nameTexF.font=[UIFont systemFontOfSize:14];
    self.nameTexF.textColor=[UIColor blackColor];
    self.nameTexF.cornerRadius=20;
    [self.view addSubview:self.nameTexF];
    
    self.codeView=[[UIView alloc]initWithFrame:CGRectMake(30, self.nameTexF.bottom+20, ScreenWidth-60, 44)];
    self.codeView.backgroundColor=[UIColor whiteColor];
    self.codeView.cornerRadius=20;
    [self.view addSubview:self.codeView];
    
    self.codeTexF=[[UITextField alloc]initWithFrame:CGRectMake(0,0, ScreenWidth-90-80, 44)];
    self.codeTexF.delegate=self;
    self.codeTexF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTexF.leftView = leftView2;
    self.codeTexF.placeholder=@"输入验证码";
    self.codeTexF.font=[UIFont systemFontOfSize:14];
    self.codeTexF.textColor=[UIColor blackColor];
    [self.codeView addSubview:self.codeTexF];
    
    UIView*lineView1=[[UIView alloc]initWithFrame:CGRectMake(20, self.nameTexF.bottom, ScreenWidth-40,0.5)];
    lineView1.backgroundColor=[MTool colorWithHexString:@"#B3B3B3"];
    [self.view addSubview:lineView1];
    
    self.codeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.codeButton.frame=CGRectMake(ScreenWidth-FitRealValue(150)-60, 5, FitRealValue(150), 34);
    [self.codeButton setTitleColor:[MTool colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButton.backgroundColor=[UIColor clearColor];
    self.codeButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.codeButton addTarget:self action:@selector(animationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeView addSubview:self.codeButton];
    
    self.passTexF=[[UITextField alloc]initWithFrame:CGRectMake(30, self.nameTexF.bottom+20, ScreenWidth-60, 44)];
    self.passTexF.delegate=self;
    self.passTexF.leftViewMode = UITextFieldViewModeAlways;
    self.passTexF.leftView = leftView3;
    self.passTexF.placeholder=@"请输入密码";
    self.passTexF.cornerRadius=20;
    self.passTexF.font=[UIFont systemFontOfSize:14];
    self.passTexF.textColor=[UIColor blackColor];
    self.passTexF.hidden=YES;
    [self.view addSubview:self.passTexF];
    
    UIView*lineView2=[[UIView alloc]initWithFrame:CGRectMake(20, self.passTexF.bottom, ScreenWidth-40, 0.3)];
    lineView2.backgroundColor=[MTool colorWithHexString:@"#B3B3B3"];
    [self.view addSubview:lineView2];
    
    
    UILabel*agreeLab=[[UILabel alloc]initWithFrame:CGRectMake(20,lineView2.bottom+FitRealValue(24) , 12*13, FitRealValue(14))];
    agreeLab.textColor=[MTool colorWithHexString:@"#888888"];
    agreeLab.text=@"登录荣知教育代表您已同意";
    agreeLab.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:agreeLab];

    self.agreeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeButton.frame=CGRectMake(agreeLab.right-20,lineView2.bottom+FitRealValue(26), 12*13, FitRealValue(14));
    self.agreeButton.tag=100;
    [self.agreeButton setBackgroundColor:[UIColor clearColor]];
    [self.agreeButton setTitle:@"荣知教育用户服务协议" forState:UIControlStateNormal];
    self.agreeButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.agreeButton setTitleColor:[MTool colorWithHexString:@"#F65555"]forState:UIControlStateNormal];
    [self.agreeButton addTarget:self action:@selector(clickAgreement:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreeButton];
    
    self.agreeButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeButton1.frame=CGRectMake(agreeLab.right-20,self.agreeButton.bottom+FitRealValue(24), 12*13, FitRealValue(14));
    self.agreeButton1.tag=101;
    [self.agreeButton1 setBackgroundColor:[UIColor clearColor]];
    [self.agreeButton1 setTitle:@"荣知教育用户隐私政策" forState:UIControlStateNormal];
    self.agreeButton1.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.agreeButton1 setTitleColor:[MTool colorWithHexString:@"#F65555"] forState:UIControlStateNormal];
    [self.agreeButton1 addTarget:self action:@selector(clickAgreement:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreeButton1];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(30, self.agreeButton1.bottom+FitRealValue(70), ScreenWidth-60, 44);
    [self.loginBtn setBackgroundColor:[MTool colorWithHexString:@"#FF6E1D"]];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    self.loginBtn.cornerRadius=20;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.forgetPassBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetPassBtn.frame=CGRectMake(ScreenWidth-FitRealValue(200),  self.loginBtn.bottom+FitRealValue(20), FitRealValue(120), 34);
    [self.forgetPassBtn setTitleColor:[MTool colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    [self.forgetPassBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetPassBtn.backgroundColor=[UIColor clearColor];
    self.forgetPassBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.forgetPassBtn.hidden=YES;
    [self.forgetPassBtn addTarget:self action:@selector(forgetPassClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetPassBtn];
    
    
    self.youkeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.youkeBtn.frame=CGRectMake(45, self.loginBtn.bottom+FitRealValue(30), ScreenWidth-90, 44);
    [self.youkeBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    self.youkeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.youkeBtn setTitleColor:[MTool colorWithHexString:@"#FF5E5E"]forState:UIControlStateNormal];
    [self.youkeBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.youkeBtn];
    
    
    
    UIView*bottomLineView=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-FitRealValue(450))/2,ScreenHeight-SafeAreaBottomHeight-FitRealValue(140), FitRealValue(450), 0.5)];
    bottomLineView.backgroundColor=[MTool colorWithHexString:@"##B3B3B3"];
    [self.view addSubview:bottomLineView];
    
    UILabel*bottomLab=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-FitRealValue(170))/2,ScreenHeight-SafeAreaBottomHeight-FitRealValue(154),FitRealValue(170), FitRealValue(28))];
    bottomLab.textColor=[MTool colorWithHexString:@"#B3B3B3"];
    bottomLab.text=@"密码登录";
    bottomLab.backgroundColor=[UIColor whiteColor];
    bottomLab.textAlignment=NSTextAlignmentCenter;
    bottomLab.font=[UIFont systemFontOfSize:14];
    self.bottomLab=bottomLab;
    [self.view addSubview:self.bottomLab];
    
    
    self.typeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.typeButton.frame=CGRectMake((ScreenWidth-FitRealValue(132))/2, bottomLineView.bottom, FitRealValue(132), FitRealValue(132));
    [self.typeButton setImage:[UIImage imageNamed:@"logintypeimg"] forState:UIControlStateNormal];
    [self.typeButton setTitleColor:[MTool colorWithHexString:@"#FF5E5E"]forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(choseType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeButton];
    
}
#pragma mark === buttonclick ===

-(void)forgetPassClick:(UIButton*)sender{
    
    forgetPassVC*vc=[forgetPassVC new];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)animationCode:(UIButton *)sender {
    
    
    if (self.nameTexF.text.length==0) {
        [DZTools showNOHud:@"请输入手机号" delay:2.0];
        
        return;
    }
    if (![MTool isValidateMobile:self.nameTexF.text]) {
        [DZTools showNOHud:@"手机号格式错误" delay:2.0];
        
        return;
    }
    [sender setCountdown:60 WithStartString:@"" WithEndString:@"获取验证码"];
    self.net.requestId=Accountsmscaptcha;
    [self.net login_sendWithMobile:self.nameTexF.text Action:@""];
    
    
    
}

- (void)choseType:(UIButton *)sender {
    
    [self.nameTexF resignFirstResponder];
    [self.passTexF resignFirstResponder];
    [self.codeTexF resignFirstResponder];
    
    
    self.passTexF.text = nil;
    self.codeTexF.text=nil;
    self.nameTexF.text=nil;
    sender.selected = !sender.selected;
    if (sender.selected==YES) {
        self.loginType=1;
        [self.typeButton setImage:[UIImage imageNamed:@"logincodeimg"] forState:UIControlStateNormal];
        self.bottomLab.text=@"验证码登录";
        self.youkeBtn.hidden=YES;
        self.passTexF.hidden=NO;
        self.codeView.hidden=YES;
        self.smallTitle.hidden=YES;
        self.bigTitle.text=@"账号密码登录";
         self.forgetPassBtn.hidden=NO;
        
    }
    else{
        self.loginType=0;
        [self.typeButton setImage:[UIImage imageNamed:@"logintypeimg"] forState:UIControlStateNormal];
        self.bottomLab.text=@"密码登录";
        self.youkeBtn.hidden=NO;
        self.passTexF.hidden=YES;
        self.codeView.hidden=NO;
        self.smallTitle.hidden=NO;
        self.bigTitle.text=@"欢迎使用点读产品";
        self.forgetPassBtn.hidden=YES;


        
    }
}
- (void)loginButtonPressed:(UIButton *)sender {
    
    [self.nameTexF resignFirstResponder];
    [self.passTexF resignFirstResponder];
    [self.codeTexF resignFirstResponder];
    
    if (self.loginType==0) {
        //验证码 登录
        if (self.codeTexF.text.length==0) {
            [DZTools showNOHud:@"请输入验证码" delay:2.0];
            
            return;
        }else{
            self.net.requestId=Accountsmslogin;
            [self.net login_indexWithMobile:self.nameTexF.text Yan:self.codeTexF.text];
        }
        
    }else{
        if (self.passTexF.text.length==0) {
            [DZTools showNOHud:@"请输入密码" delay:2.0];
            
            return;
        }
        
        self.net.requestId=Accountlogin;
        [self.net login_pwdloginWithMobile:self.nameTexF.text Password:self.passTexF.text];
        
    }
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ((textField == self.nameTexF && textField.text.length>10)&&![string isEqualToString:@""]) {
        return NO;
    }
    //普通登录密码长度限制
    if (self.loginType == 1 && (textField == self.passTexF && textField.text.length>19)&&![string isEqualToString:@""]) {
        return NO;
    }
    //验证码登录长度限制
    if (self.loginType == 0 && (textField == self.passTexF && textField.text.length>5)&&![string isEqualToString:@""]) {
        return NO;
    }
    if (self.loginType == 0) {
        if (textField == self.passTexF) {
            self.passWorldStr=textField.text;
        }
    }
    return YES;
}

- (void)clickAgreement:(UIButton *)sender {
    
    if (sender.tag==100) {
        
        WebViewViewController *webVC = [[WebViewViewController alloc]init];
        webVC.urlStr = @"http://api.bclc.com.cn/agreement/UserAgreement.html";
        webVC.titleStr=@"荣知教育用户服务协议";
        [self presentViewController:webVC animated:YES completion:nil];
        
    }
    else{
        WebViewViewController *webVC = [[WebViewViewController alloc]init];
        webVC.urlStr = @"http://api.bclc.com.cn/agreement/PrivacyAgreement.html";
        webVC.titleStr=@" 荣知教育用户隐私政策";
        [self presentViewController:webVC animated:YES completion:nil];
    }
    
}



#pragma --mark textFieldDelegate
//调用delete方法,<UITextFieldDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//释放第一响应者
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nameTexF resignFirstResponder];
    [self.passTexF resignFirstResponder];
    [self.codeTexF resignFirstResponder];
    
}

#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*headDic=result[@"head"];
    if ([headDic[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:headDic[@"res_msg"] delay:2];
        return;
    }
    else{
        NSDictionary*bodyDic=result[@"body"];
        switch (request.requestId) {
            case Accountlogin:{
                [DZTools showOKHud:headDic[@"res_msg"] delay:2];
                User *user = [User mj_objectWithKeyValues:bodyDic];
                [User saveUser:user];
                [self dismissViewControllerAnimated:YES completion:nil];

            }
                break;
            case Accountsmscaptcha:{
                
               [DZTools showNOHud:headDic[@"res_msg"] delay:2];
                
            }
                break;
            case Accountsmslogin:{
                [DZTools showOKHud:headDic[@"res_msg"] delay:2];
                User *user = [User mj_objectWithKeyValues:bodyDic];
                [User saveUser:user];
                [self dismissViewControllerAnimated:YES completion:nil];

            }
                break;
                
            default:
                break;
        }
    }
}
- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}



@end
