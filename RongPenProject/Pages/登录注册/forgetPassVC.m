//
//  forgetPassVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/21.
//

#import "forgetPassVC.h"
#import "UIButton+Code.h"

typedef enum : NSUInteger{
    Submit,//提交
    Accountsmscaptcha,//获取验证码
    Login_repwdjy,//忘记密码-验证码校验
}requestIdEnum;

@interface forgetPassVC ()<UITextFieldDelegate,NetManagerDelegate>

@property (strong,nonatomic)   UITextField                  *codeTexF;
@property (strong,nonatomic)   UITextField                  *passTexF;
@property (strong,nonatomic)   UITextField                  *nameTexF;
@property (strong,nonatomic)   UIButton                     *codeButton;
@property (strong,nonatomic)   UIView                       *codeView;
@property (strong,nonatomic)   UIButton                     *loginBtn;
@property (nonatomic,strong)   NetManager                   *net;
@property (nonatomic,strong)   NSString                     *uidStr;

@end

@implementation forgetPassVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.topview.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"忘记密码";
    if (self.viewTag==100) {
    self.toptitle.text=@"重置密码";
    }
    self.lineview.hidden=NO;
    self.leftImgBtn.hidden=NO;
    [self createUI];
    
}
-(void)setViewTag:(NSInteger)viewTag{
    
    _viewTag=viewTag;
}
-(void)createUI{
    
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 44)];
    leftView1.backgroundColor=[UIColor clearColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 44)];
    leftView2.backgroundColor=[UIColor clearColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 44)];
    leftView3.backgroundColor=[UIColor clearColor];
    self.nameTexF=[[UITextField alloc]initWithFrame:CGRectMake(30,SafeAreaTopHeight+FitRealValue(130), ScreenWidth-60, 44)];
    
    self.nameTexF.delegate=self;
    self.nameTexF.leftViewMode = UITextFieldViewModeAlways;
    self.nameTexF.leftView = leftView1;
    self.nameTexF.backgroundColor=[UIColor whiteColor];
    self.nameTexF.placeholder=@"手机号";
    self.nameTexF.font=[UIFont systemFontOfSize:14];
    self.nameTexF.textColor=[UIColor blackColor];
    self.nameTexF.cornerRadius=20;
    [self.view addSubview:self.nameTexF];
    
    UIView*lineView1=[[UIView alloc]initWithFrame:CGRectMake(20, self.nameTexF.bottom, ScreenWidth-40,0.5)];
    lineView1.backgroundColor=[MTool colorWithHexString:@"#B3B3B3"];
    [self.view addSubview:lineView1];
    
    self.codeView=[[UIView alloc]initWithFrame:CGRectMake(30, self.nameTexF.bottom+20, ScreenWidth-60, 44)];
    self.codeView.backgroundColor=[UIColor whiteColor];
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
    self.codeButton.frame=CGRectMake(ScreenWidth-FitRealValue(150)-60, 5, FitRealValue(150), 34);
    [self.codeButton setTitleColor:[MTool colorWithHexString:@"#B3B3B3"] forState:UIControlStateNormal];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButton.backgroundColor=[UIColor clearColor];
    self.codeButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.codeButton addTarget:self action:@selector(animationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeView addSubview:self.codeButton];
    
    UIView*lineView2=[[UIView alloc]initWithFrame:CGRectMake(20, self.codeView.bottom, ScreenWidth-40, 0.3)];
    lineView2.backgroundColor=[MTool colorWithHexString:@"#B3B3B3"];
    [self.view addSubview:lineView2];
    
    self.passTexF=[[UITextField alloc]initWithFrame:CGRectMake(30, lineView2.bottom+20, ScreenWidth-60, 44)];
    self.passTexF.delegate=self;
    self.passTexF.leftViewMode = UITextFieldViewModeAlways;
    self.passTexF.leftView = leftView3;
    self.passTexF.placeholder=@"输入6-20位新密码";
    self.passTexF.font=[UIFont systemFontOfSize:14];
    self.passTexF.textColor=[UIColor blackColor];
    [self.view addSubview:self.passTexF];
    
    UIView*lineView4=[[UIView alloc]initWithFrame:CGRectMake(20, self.passTexF.bottom, ScreenWidth-40, 0.5)];
    lineView4.backgroundColor=[MTool colorWithHexString:@"#B3B3B3"];
    [self.view addSubview:lineView4];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(30, lineView4.bottom+FitRealValue(134), ScreenWidth-60, 44);
    [self.loginBtn setBackgroundColor:[MTool colorWithHexString:@"#FF6E1D"]];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    self.loginBtn.cornerRadius=20;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
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
    [self.net login_sendWithMobile:self.nameTexF.text Action:@"findpwd"];
    
    
    
}
- (void)loginButtonPressed:(UIButton *)sender {
    
    if (self.nameTexF.text.length==0) {
        [DZTools showNOHud:@"请输入手机号" delay:2.0];
        
        return;
    }
    if (![MTool isValidateMobile:self.nameTexF.text]) {
        [DZTools showNOHud:@"手机号格式错误" delay:2.0];
        
        return;
    }
    if (self.codeTexF.text.length==0) {
        [DZTools showNOHud:@"请输入验证码" delay:2.0];
        
        return;
    }
    self.net.requestId=Login_repwdjy;
    [self.net login_repwdjyWithMobile:self.nameTexF.text Yan:self.codeTexF.text];
    
    
}
-(void)SubmitClick{
    
    self.net.requestId=Submit;
    [self.net login_repwddoWithUid:self.uidStr Newpwd: self.passTexF.text];
    
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
            case Submit:{
                [DZTools showOKHud:headDic[@"res_msg"] delay:2];
                User *user = [User mj_objectWithKeyValues:bodyDic];
                [User saveUser:user];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
                break;
            case Login_repwdjy:{
                self.uidStr=bodyDic[@"uid"];
                [self SubmitClick];
                
            }
                break;
            case Accountsmscaptcha:{
                
                [DZTools showNOHud:headDic[@"res_msg"] delay:2];
                
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
