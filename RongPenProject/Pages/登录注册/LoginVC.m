//
//  LoginVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "LoginVC.h"
#import "UIButton+Code.h"

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
@property (nonatomic,strong)   NetManager                   *net;
@property (strong,nonatomic)   UIButton                     *typeButton;
@property (strong,nonatomic)   UIButton                     *agreeButton;
@property (strong, nonatomic)  NSString                     *nickname;
@property (nonatomic, strong)  UITextView                   *tv_result;
@property (nonatomic, strong)  UITextField                  *tf_timeout;
@property (nonatomic,assign)   NSInteger                    loginType;//0 账号密码  1手机登录
@property (nonatomic, strong)  NSString                     *openidStr;
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
    
    UILabel*bigTitle=[[UILabel alloc]initWithFrame:CGRectMake(20, FitRealValue(72), ScreenWidth-40, FitRealValue(24))];
    bigTitle.text=@"欢迎使用点读产品";
    bigTitle.font=[UIFont boldSystemFontOfSize:24];
    bigTitle.textColor=[MTool colorWithHexString:@"#212121"];
    [self.view addSubview:bigTitle];
    
    UILabel*smallTitle=[[UILabel alloc]initWithFrame:CGRectMake(20,bigTitle.bottom+FitRealValue(10), ScreenWidth-40, FitRealValue(12))];
    smallTitle.text=@"未注册过的手机号将自动创建账号";
    smallTitle.font=[UIFont systemFontOfSize:12];
    smallTitle.textColor=[MTool colorWithHexString:@"#4E4E4E"];
    [self.view addSubview:smallTitle];
    
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView1.backgroundColor=[UIColor clearColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView2.backgroundColor=[UIColor clearColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    leftView3.backgroundColor=[UIColor clearColor];
    
    
    self.nameTexF=[[UITextField alloc]initWithFrame:CGRectMake(45, smallTitle.bottom+FitRealValue(52), ScreenWidth-90, 44)];
    self.nameTexF.delegate=self;
    self.nameTexF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTexF.leftView = leftView1;
    self.nameTexF.backgroundColor=[UIColor whiteColor];
    self.nameTexF.placeholder=@"手机号";
    self.nameTexF.font=[UIFont systemFontOfSize:14];
    self.nameTexF.textColor=[UIColor blackColor];
    self.nameTexF.cornerRadius=20;
    [self.view addSubview:self.nameTexF];
    
    self.codeView=[[UIView alloc]initWithFrame:CGRectMake(45, self.nameTexF.bottom+20, ScreenWidth-90, 44)];
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
    
    self.codeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.codeButton.frame=CGRectMake(ScreenWidth-90-80, 5, 60, 34);
    [self.codeButton setTitleColor:[MTool colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButton.backgroundColor=[UIColor clearColor];
    self.codeButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.codeButton addTarget:self action:@selector(animationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeView addSubview:self.codeButton];
    
    self.passTexF=[[UITextField alloc]initWithFrame:CGRectMake(45, self.nameTexF.bottom+20, ScreenWidth-90, 44)];
    self.passTexF.delegate=self;
    self.passTexF.leftViewMode = UITextFieldViewModeAlways;
    self.passTexF.leftView = leftView3;
    self.passTexF.placeholder=@"请输入密码";
    self.passTexF.cornerRadius=20;
    self.passTexF.font=[UIFont systemFontOfSize:14];
    self.passTexF.textColor=[UIColor blackColor];
    self.passTexF.hidden=YES;
    [self.view addSubview:self.passTexF];
    
    
    self.agreeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeButton.frame=CGRectMake(0,self.passTexF.bottom+FitRealValue(30), ScreenWidth, 20);
    [self.agreeButton setBackgroundColor:[UIColor clearColor]];
    [self.agreeButton setTitle:@"登录/注册即视为同意《注册服务协议》" forState:UIControlStateNormal];
    self.agreeButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.agreeButton addTarget:self action:@selector(clickAgreement:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreeButton];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(45, self.passTexF.bottom+20, ScreenWidth-90, 44);
    [self.loginBtn setBackgroundColor:[MTool colorWithHexString:@"#FF6E1D"]];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    self.loginBtn.cornerRadius=20;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.typeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.typeButton.frame=CGRectMake(ScreenWidth-120, self.loginBtn.bottom+20,80, 30);
    [self.typeButton setBackgroundColor:[UIColor clearColor]];
    [self.typeButton setTitle:@"密码登录" forState:UIControlStateNormal];
    self.typeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(choseType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.typeButton];
    
   


    
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
//    self.net.requestId=Accountsmscaptcha;
//    [self.net accountsmscaptchaWithUname:self.nameTexF.text];
    
    
    
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
        [self.typeButton setTitle:@"验证码登录" forState:UIControlStateNormal];
        self.passTexF.hidden=NO;
        self.codeView.hidden=YES;
        
    }
    else{
        self.loginType=0;
        [self.typeButton setTitle:@"密码登录" forState:UIControlStateNormal];
        self.passTexF.hidden=YES;
        self.codeView.hidden=NO;
        
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
//            self.net.requestId=Accountsmslogin;
//            [self.net accountSmsloginWithOpenid:nil phone:self.nameTexF.text smscaptcha:self.codeTexF.text];
        }
        
    }else{
        if (self.passTexF.text.length==0) {
            [DZTools showNOHud:@"请输入密码" delay:2.0];
            
            return;
        }
        
//        self.net.requestId=Accountsmslogin;
//        [self.net accountloginWithUname:self.nameTexF.text Passwd:self.passTexF.text];
        
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
    //    BLWebViewController *webVC = [[BLWebViewController alloc]init];
    //    webVC.title = @"用户协议";
    //    if (appIsForVest) {
    //        webVC.url = [NSURL URLWithString:@"http://www.yunyingyue.com/web/zhj/xiyi.html"];
    //    } else {
    //    webVC.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@serviceProvision.html?app=%@",HTMLSTR,APPID]];
    //    }
    //     webVC.url = [NSURL URLWithString:[NSString stringWithFormat:XIEYIURL]];
    //
    //    [self.navigationController pushViewController:webVC animated:YES];
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
    if ([result[@"code"]intValue]!=200) {
        
        [DZTools showNOHud:result[@"msg"] delay:2];
        return;
    }
    else{
        switch (request.requestId) {
            case Accountlogin:{
                
                [DZTools showOKHud:result[@"msg"] delay:2];
                
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
