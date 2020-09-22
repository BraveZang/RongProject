//
//  confirmIndexVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//

#import "ConfirmIndexVC.h"
#import "ConfirmIndexCell.h"
#import "RightSlidingMenuView.h"

@interface ConfirmIndexVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property(nonatomic,strong)   UILabel                           *topLab;
@property(nonatomic,strong)   UITableView                       *tableview;
@property(nonatomic,strong)   RightSlidingMenuView              *rightslidingmenuview;
@property(nonatomic,strong)   NetManager                        *net;
@end

@implementation ConfirmIndexVC

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
    self.topview.hidden=NO;
    self.toptitle.hidden=NO;
    self.rightImgBtn.hidden=NO;
    [self.rightImgBtn setImage:[UIImage imageNamed:@"toprightbtnimg"] forState:UIControlStateNormal];
    self.rightImgBtn.frame=CGRectMake(ScreenWidth-30, SafeAreaTopHeight-64+(64-15)/2, 30, 30);
    [self.rightImgBtn addTarget:self action:@selector(showRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self createUI];
    [self initTableView];
    
}
- (BOOL)prefersStatusBarHidden

{
    
    return YES;//隐藏为YES，显示为NO
    
}  
#pragma mark - Getter

- (RightSlidingMenuView *)rightslidingmenuview {
    if (!_rightslidingmenuview) {
        _rightslidingmenuview = [[RightSlidingMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _rightslidingmenuview;
}
-(void)createUI{
    
    self.topLab=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-FitRealValue(460)-35,SafeAreaTopHeight-64+(64-15)/2, FitRealValue(460),30)];
    self.topLab.textAlignment=NSTextAlignmentRight;
    self.topLab.font=[UIFont systemFontOfSize:FitRealValue(24)];
    self.topLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self.view addSubview:self.topLab];
    self.topLab.text=@"测试 三年级上（新概念）";
}

- (void)showRightAction
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.rightslidingmenuview];
}
#pragma mark - tableview
-(void)initTableView{
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.tableFooterView=[UIView new];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIdentifier = @"ConfirmIndexCell";
    ConfirmIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ConfirmIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    float cellH=FitRealValue(280);
    if (IS_IPAD) {
        cellH=cellH*2/3;
    }
    tableView.rowHeight=cellH;
    if (indexPath.section==0) {
        [cell.img setImage:[UIImage imageNamed:@"tingxie"]];
        cell.titleLab.text=@"听写练习";
    }
    else{
        [cell.img setImage:[UIImage imageNamed:@"huyi"]];
        cell.titleLab.text=@"中英互译";
    }
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}
@end
