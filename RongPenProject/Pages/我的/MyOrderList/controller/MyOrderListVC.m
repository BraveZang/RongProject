//
//  MyOrderListVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "MyOrderListVC.h"
#import "MyOrderListCell.h"
#import "MyOrderListModel.h"
#import "MyorderDetailVC.h"


@interface MyOrderListVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic, strong)  NetManager                        *net;
@property (nonatomic, strong)  NSMutableArray                    *datAry;
@property (nonatomic, assign)  NSInteger                         page;
@property (nonatomic, assign)  BOOL                              isfresh;




@end

@implementation MyOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datAry=[NSMutableArray arrayWithCapacity:0];
    self.toptitle.hidden=NO;
    self.toptitle.text=@"我的订单";
    self.leftImgBtn.hidden=NO;
    [self initTableView];
    [self refresh];
    
}


- (void)initTableView {
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(void) {
           NSLog(@"下拉刷新");
           [self refresh];
       }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           NSLog(@"上拉加载更多");
           [self loadMore];
       }];
    float cellH=FitRealValue(436);
    if (IS_IPAD) {
        cellH=cellH*2/3;
    }
    self.tableView.rowHeight = cellH;
    
    [self.view addSubview:self.tableView];
}


#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"MyOrderListCell";
    MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MyOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.datAry[indexPath.section];
    cell.Block = ^(NSString * _Nonnull str) {
        if ([str isEqualToString:@"查看订单"]) {
            MyOrderListModel*model=self.datAry[indexPath.section];
            MyorderDetailVC*vc=[MyorderDetailVC new];
            vc.ordersnStr=model.ordersn;
            vc.orderidStr=model.orderid;
            [self.navigationController pushViewController: vc animated:YES];
        }
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    MyOrderListModel*model=self.datAry[indexPath.section];
//    MyorderDetailVC*vc=[MyorderDetailVC new];
//    vc.ordersnStr=model.ordersn;
//    vc.orderidStr=model.orderid;
//    [self.navigationController pushViewController: vc animated:YES];
  
    
}
- (void)refresh {
    _page = 1;
    [self getDataArrayFromServerIsRefresh:YES];
}
- (void)loadMore {
    _page = _page + 1;
    [self getDataArrayFromServerIsRefresh:NO];
}
- (void)getDataArrayFromServerIsRefresh:(BOOL)isRefresh {
    self.isfresh=isRefresh;
    self.net.requestId=1001;
    [self.net Order_indexWithUid:[User getUserID] page:[NSString stringWithFormat:@"%ld", self.page]];
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.isfresh==YES) {
            self.datAry=[NSMutableArray arrayWithCapacity:0];
        }
        //辅材列表
        NSArray * dataArray = result[@"body"];
        for(NSDictionary *dic in dataArray){
            MyOrderListModel*model=[MyOrderListModel mj_objectWithKeyValues:dic];
            [self.datAry addObject:model];
        }
        
        [self.tableView reloadData];
        
        
    }
    
}

- (void)requestError:(NetManager *)request error:(NSError*)error{
    
}

- (void)requestStart:(NetManager *)request{
    
}

#pragma mark -lazy
- (NetManager *)net{
    if (!_net) {
        self.net = [[NetManager alloc] init];
        _net.delegate = self;
    }
    return _net;
}

@end
