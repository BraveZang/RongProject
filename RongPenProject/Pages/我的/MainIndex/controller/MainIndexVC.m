//
//  MainIndexVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "MainIndexVC.h"
#import "LoginVC.h"
#import "MainSetVC.h"
#import "MainFanKuiVC.h"
#import "MainMessageVC.h"
#import "MainCourseVC.h"
#import "MainInfoSettingVC.h"
@interface MainIndexVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;
@property (nonatomic, strong)  UIView               *headerView;
@property (nonatomic, strong)  UIView               *footerView;
@property (nonatomic, strong)  UILabel              *nameLabel;
@property (nonatomic, strong)  UILabel              *classLabel;
@property (nonatomic, strong)  UIButton             *loginBtn;
@property (nonatomic, strong)  UIButton             *editorBtn;
@property (nonatomic, strong)  UIImageView          *heardImg;

@end

@implementation MainIndexVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeardView];
    [self createFooterView];
    [self  initTableView];
    
}

-(void)createHeardView{
    
    float imgH=FitRealValue(108);
    float imgY=FitRealValue(60);
    float heardViewH=FitRealValue(480);
    float btnH=FitRealValue(220);
    if (IS_IPAD) {
        imgH=FitRealValue(108)*2/3;
        heardViewH=FitRealValue(480)*2/3;
        btnH=FitRealValue(220)*2/3;
    }
    float btnW=70;
    float btnSpace=(ScreenWidth-FitRealValue(80)*2-btnW*3)/2;
    
    
    self.headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, heardViewH)];
    self.headerView.backgroundColor=[UIColor whiteColor];
    self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, imgY, imgH, imgH)];
    self.heardImg.cornerRadius=imgH/2;
    self.heardImg.borderWidth=0.5;
    self.heardImg.borderColor=[MTool colorWithHexString:@"#D12E2E"];
    [self.headerView addSubview:self.heardImg];
    
    self.nameLabel=[MTool quickCreateLabelWithleft:self.heardImg.right+FitRealValue(20) top:imgY width:500*SCREEN_WIDTH/750 heigh:imgH/2 title:@""];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    self.nameLabel.text=@"名字";
    self.nameLabel.hidden=YES;
    self.nameLabel.textColor=[MTool colorWithHexString:@"#212121"];
    [self.headerView addSubview:self.nameLabel];
    
    self.classLabel=[MTool quickCreateLabelWithleft:self.heardImg.right+FitRealValue(20) top:self.nameLabel.bottom width:500*SCREEN_WIDTH/750 heigh:imgH/2 title:@""];
    self.classLabel.font=[UIFont systemFontOfSize:13];
    self.classLabel.text=@"班级";
    self.classLabel.hidden=YES;
    self.classLabel.textColor=[MTool colorWithHexString:@"#888888"];
    [self.headerView addSubview:self.classLabel];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(self.heardImg.right+FitRealValue(20), imgY, 20*3, imgH);
    [self.loginBtn setTitle:@"未登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.loginBtn];
    
    self.editorBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editorBtn.frame=CGRectMake(ScreenWidth-FitRealValue(120), imgY, FitRealValue(120), imgH);
    [self.editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editorBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_editorBtn addTarget:self action:@selector(setInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.editorBtn setTitleColor:[MTool colorWithHexString:@"#FF8181"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.editorBtn];
    
    UIView*lineView1=[[UIView alloc]initWithFrame:CGRectMake(0, self.heardImg.bottom+FitRealValue(32), ScreenWidth, 12)];
    lineView1.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    [self.headerView addSubview:lineView1];
    
    UIButton*myCourse=[UIButton buttonWithType:UIButtonTypeCustom];
    myCourse.frame=CGRectMake(FitRealValue(80), lineView1.bottom, btnW, btnH);
    [myCourse setTitle:@"我的课程" forState:UIControlStateNormal];
    [myCourse addTarget:self action:@selector(myCourseBtnClick) forControlEvents:UIControlEventTouchUpInside];

    myCourse.titleLabel.font=[UIFont systemFontOfSize:14];
    //    myCourse.titleLabel.textAlignment=NSTextAlignmentCenter;
    [myCourse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myCourse setImage:[UIImage imageNamed:@"mycourse"] forState:UIControlStateNormal];
    //    [myCourse layoutButtonWithEdgeInsetsStyle:TYButtonEdgeInsetsStyleTop imageTitleSpace:0];
    myCourse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [myCourse setTitleEdgeInsets:UIEdgeInsetsMake(myCourse.imageView.frame.size.height ,-myCourse.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不
    if (@available(iOS 13.0, *)) {
        
        [myCourse setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 10.0,0.0, -myCourse.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
        
    }
    else{
        [myCourse setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 0.0,0.0, -myCourse.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    [self.headerView addSubview:myCourse];
    
    UIButton*myShop=[UIButton buttonWithType:UIButtonTypeCustom];
    myShop.frame=CGRectMake(myCourse.right+btnSpace,  lineView1.bottom, btnW, btnH);
    [myShop setTitle:@"我的商城" forState:UIControlStateNormal];
    myShop.titleLabel.font=[UIFont systemFontOfSize:14];
    [myShop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myShop setImage:[UIImage imageNamed:@"myShop"] forState:UIControlStateNormal];
    myShop.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [myShop setTitleEdgeInsets:UIEdgeInsetsMake(myShop.imageView.frame.size.height ,-myShop.imageView.frame.size.width, 0.0,0.0)];
    if (@available(iOS 13.0, *)) {
        
        [myShop setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 10.0,0.0, -myShop.titleLabel.bounds.size.width)];
    }
    else{
        [myShop setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 0.0,0.0, -myShop.titleLabel.bounds.size.width)];
    }
    [self.headerView addSubview:myShop];
    
    UIButton*myMssage=[UIButton buttonWithType:UIButtonTypeCustom];
    myMssage.frame=CGRectMake(myShop.right+btnSpace,  lineView1.bottom, btnW, btnH);
    [myMssage setTitle:@"我的消息" forState:UIControlStateNormal];
    myMssage.titleLabel.font=[UIFont systemFontOfSize:14];
    [myMssage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [myMssage setImage:[UIImage imageNamed:@"mymessage"] forState:UIControlStateNormal];
    myMssage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [myMssage addTarget:self action:@selector(messageBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [myMssage setTitleEdgeInsets:UIEdgeInsetsMake(myMssage.imageView.frame.size.height ,-myMssage.imageView.frame.size.width, 0.0,0.0)];
    if (@available(iOS 13.0, *)) {
        
        [myMssage setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 10.0,0.0, -myMssage.titleLabel.bounds.size.width)];
    }
    else{
        [myMssage setImageEdgeInsets:UIEdgeInsetsMake(-30.0, 0.0,0.0, -myMssage.titleLabel.bounds.size.width)];
    }
    [self.headerView addSubview:myMssage];
    
    UIView*lineView2=[[UIView alloc]initWithFrame:CGRectMake(0, myMssage.bottom, ScreenWidth, 12)];
    lineView2.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    [self.headerView addSubview:lineView2];
    
}
-(void)createFooterView{
    float footerViewH=FitRealValue(240);
    if (IS_IPAD) {
        footerViewH=FitRealValue(240)*2/3;
    }
    self.footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,footerViewH)];
    self.footerView.backgroundColor=[UIColor clearColor];
    
    UIButton*footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.frame=CGRectMake(44, footerViewH-40, ScreenWidth-88, 40);
    footBtn.borderColor=[MTool colorWithHexString:@"#D12E2E"];
    footBtn.borderWidth=0.5;
    [footBtn setTitleColor:[MTool colorWithHexString:@"#FF8181"] forState:UIControlStateNormal];
    [footBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    footBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.footerView addSubview:footBtn];
}
#pragma mark buttonClick
-(void)loginBtnClick{
    
    LoginVC*vc=[LoginVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)messageBtnClick{
    
    MainMessageVC*vc=[MainMessageVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)myCourseBtnClick{
    MainCourseVC*vc=[MainCourseVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)setInfoClick{
    MainInfoSettingVC*vc=[MainInfoSettingVC new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(110);
    if (IS_IPAD) {
        cellH=FitRealValue(110)*2/3;
    }
    self.tableView.rowHeight = cellH;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView=self.footerView;
    [self.view addSubview:self.tableView];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    if (indexPath.row==0) {
        cell.textLabel.text=@"蓝牙笔连接";
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"账号注销";
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"设置";
    }
    if (indexPath.row==3) {
        cell.textLabel.text=@"问题反馈";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==2) {
        MainSetVC*vc=[MainSetVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==3) {
        MainFanKuiVC*vc=[MainFanKuiVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
