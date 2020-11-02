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
#import <AlipaySDK/AlipaySDK.h>
#import "TuiKuanView.h"
#import "TuiKuandetailVC.h"
#import "OrderLogisticsVC.h"


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
    self.rightImgBtn.hidden=NO;
    self.toptitle.text=@"我的订单";
    self.leftImgBtn.hidden=NO;
    [self initTableView];
    [self refresh];
    
}
-(void)setTypeStr:(NSString *)typeStr{
    _typeStr=typeStr;
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
    
    NSString *cellIdentifier =[NSString stringWithFormat:@"MyOrderListCell%ld",indexPath.section];
    MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MyOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.datAry[indexPath.section];
    MyOrderListModel*model=self.datAry[indexPath.section];
    cell.Block = ^(NSString * _Nonnull str) {
        if ([str isEqualToString:@"查看订单"]) {
//            MyOrderListModel*model=self.datAry[indexPath.section];
//            MyorderDetailVC*vc=[MyorderDetailVC new];
//            vc.ordersnStr=model.ordersn;
//            vc.orderidStr=model.orderid;
//            [self.navigationController pushViewController: vc animated:YES];
        }
        if ([str isEqualToString:@"取消订单"]) {
            
            self.net.requestId=1010;
            [self.net Order_cancelWithUid:[User getUserID] orderid:model.orderid];
            
        }
        if ([str isEqualToString:@"去付款"]) {
            if ([model.type isEqualToString:@"直播"]) {
                self.net.requestId=1011;
                [self.net Pay_zbpayUid:[User getUserID] Ordersn:model.ordersn];
            }
            else{
                
                self.net.requestId=1011;
                [self.net Pay_buyWithUid:[User getUserID] Ordersn:model.ordersn];
            }
        }
        if ([str isEqualToString:@"退款"]) {
            TuiKuanView*postVC=[TuiKuanView new];
            postVC.orderidStr=model.orderid;
            postVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:postVC animated:YES completion:nil];
            
            
        }
        if ([str isEqualToString:@"提交物流信息"]) {
            TuiKuandetailVC*vc=[TuiKuandetailVC new];
            vc.tkorderidStr=model.tkorderid;
            vc.orderidStr=model.orderid;
            [self.navigationController pushViewController: vc animated:YES];
        }
        if ([str isEqualToString:@"确认收货"]) {
                    
            self.net.requestId=1012;
            [self.net Order_confirmWithUid:[User getUserID] orderid:model.orderid];
             
            }
//        if ([str isEqualToString:@"查看物流"]) {
        if ([str isEqualToString:@"查看订单"]) {

            OrderLogisticsVC*vc=[OrderLogisticsVC new];
            vc.ordersnStr=model.ordersn;
            vc.wlordersnStr=model.wlordersn;
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
    [self.net Order_indexWithUid:[User getUserID] page:[NSString stringWithFormat:@"%ld", self.page] type:self.typeStr];
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
        if (request.requestId==1001) {
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
       if (request.requestId==1010){
            [self refresh];
            
        }
        if (request.requestId==1010){
            
            [self refresh];
        }
        if (request.requestId==1011) {//
            NSString*bodyStr=result[@"body"];
            [[AlipaySDK defaultService] payOrder:bodyStr
                                      fromScheme:@"none.RongPenProject1"
                                        callback:^(NSDictionary *resultDic) {
                NSLog(@"-------%@", resultDic);
            }];
            
        }
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
