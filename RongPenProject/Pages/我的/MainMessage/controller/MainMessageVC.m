//
//  MainMessageVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "MainMessageVC.h"
#import "MainMessageCell.h"

@interface MainMessageVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property(nonatomic, strong)   UITableView       *tableView;
@property (nonatomic, strong) NetManager                *net;
@end

@implementation MainMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.toptitle.text=@"消息";
    self.leftImgBtn.hidden=NO;
    
    [self getUserMessageData];
    [self initTableView];
}

- (void)getUserMessageData{
    User*user=[User getUser];
    [self.net Message_indexWithUid:user.uid];
}

#pragma mark UITableViewDataSource
- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.tableFooterView=[UIView new];
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(void) {
    //           NSLog(@"下拉刷新");
    //           [self refresh];
    //       }];
    //       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //           NSLog(@"上拉加载更多");
    //           [self loadMore];
    //       }];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MainMessageCell";
    MainMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MainMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section==1) {
        //          cell.usermodel=self.infoAry[indexPath.row];
        //          cell.MessageModel=self.datary[indexPath.row];
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellH=120*SCREEN_WIDTH/750;
    if (IS_IPAD) {
        return cellH*2/3;
    }
    else{
        return cellH;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}


#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {//新增地址
            [DZTools showOKHud:code[@"res_msg"] delay:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1003) {//编辑地址
            [DZTools showOKHud:code[@"res_msg"] delay:2];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1004) {//删除地址
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.net.requestId==1002) {
            
           
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
