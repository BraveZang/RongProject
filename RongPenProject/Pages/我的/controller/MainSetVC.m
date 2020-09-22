//
//  MainSetVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import "MainSetVC.h"
#import "MainSetCell.h"

@interface MainSetVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;
@end

@implementation MainSetVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.leftBarButtonItem=nil;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"设置";
    [self  initTableView];
}

#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-49) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(110);
    if (IS_IPAD) {
        cellH=FitRealValue(110)*2/3;
    }
    self.tableView.rowHeight = cellH;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 3;
    }
    else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor=RGBA(241, 244, 249, 1);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MainSetCell";
    MainSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MainSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.titleLab.text=@"版本更新";
            cell.contentLab.text=@"当前已是最新版本";
            
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"清除缓存";
            cell.contentLab.text=@"当前缓存234M";
            
        }
        if (indexPath.row==2) {
            cell.titleLab.text=@"关于我们";
            cell.contentLab.hidden=YES;
            
        }
    }
    else{
        if (indexPath.row==0) {
            cell.titleLab.text=@"荣知教育用户协议";
            cell.contentLab.hidden=YES;
            
        }
        if (indexPath.row==1) {
            cell.titleLab.text=@"荣知教育隐私协议";
            cell.contentLab.hidden=YES;
            
        }
    }
    return cell;
}
@end
