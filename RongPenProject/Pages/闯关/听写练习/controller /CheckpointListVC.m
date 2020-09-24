//
//  CheckpointListVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "CheckpointListVC.h"
#import "CheckpointListCell.h"
#import "CheckpointResultVC.h"

@interface CheckpointListVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView          *tableView;

@end

@implementation CheckpointListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.toptitle.text=@"听写练习";
    self.leftImgBtn.hidden=NO;
    [self initTableView];
}

#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    float cellH=FitRealValue(560);
    if (IS_IPAD) {
        cellH=cellH*2/3;
    }
    self.tableView.rowHeight = cellH;
    [self.view addSubview:self.tableView];
}

#pragma mark – Network



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CheckpointListCell";
    CheckpointListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CheckpointListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CheckpointResultVC*vc=[CheckpointResultVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
