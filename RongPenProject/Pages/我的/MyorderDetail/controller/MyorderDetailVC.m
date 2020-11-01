//
//  MyorderDetailVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "MyorderDetailVC.h"
#import "MyorderDetailCell.h"
#import "MyorderDetailModel.h"
#import "MyorderDetailTowCell.h"

@interface MyorderDetailVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic, strong)  UIView                            *bottomView;
@property (nonatomic, strong)  NetManager                        *net;
@property (nonatomic, strong)  MyorderDetailModel                *model;
@property (nonatomic, assign)  NSInteger                         cellH1;
@property (nonatomic, assign)  NSInteger                         cellH2;
@property (nonatomic, strong)  UIButton                          *bottomBtn1;
@property (nonatomic, strong)  UIButton                          *bottomBtn2;



@end
@implementation MyorderDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.toptitle.hidden=NO;
    self.toptitle.text=@"我的订单";
    self.leftImgBtn.hidden=NO;
    self.rightImgBtn.hidden=NO;
    [self initTableView];
    [self getOrderDetailInfoUrl];
}
-(void)setOrderidStr:(NSString *)orderidStr{
    _orderidStr=orderidStr;
}
-(void)setOrdersnStr:(NSString *)ordersnStr{
    _ordersnStr=ordersnStr;
}
- (void)initTableView {
    float btnW=FitRealValue(200);
    float btnH=FitRealValue(60);
    float bottonH=FitRealValue(120);
    float space=(ScreenWidth-btnW*2)/3;

    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-SafeAreaBottomHeight-bottonH, ScreenWidth,bottonH)];
    self.bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.bottomBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn1.frame=CGRectMake(space, (bottonH-btnH)/2, btnW, btnH);
    [self.bottomBtn1 setTitleColor:[MTool colorWithHexString:@"#FF6B6B"] forState:UIControlStateNormal];
    self.bottomBtn1.titleLabel.font=[UIFont systemFontOfSize:16];
    self.bottomBtn1.borderWidth=0.5;
    self.bottomBtn1.borderColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.bottomBtn1.hidden=YES;
    [self.bottomView addSubview: self.bottomBtn1];
    
    self.bottomBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomBtn2.frame=CGRectMake(space+self.bottomBtn1.right, (bottonH-btnH)/2, btnW, btnH);
    [self.bottomBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomBtn2.titleLabel.font=[UIFont systemFontOfSize:16];
    self.bottomBtn2.backgroundColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.bottomBtn2.hidden=YES;
    [self.bottomView addSubview: self.bottomBtn2];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight-FitRealValue(120)) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.cellH1=FitRealValue(620);
    self.cellH2=FitRealValue(400);
    
    if (IS_IPAD) {
        self.cellH1=self.cellH1*2/3;
        self.cellH2=self.cellH2*2/3;
        
    }
    
    [self.view addSubview:self.tableView];
}


#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.model.orderstatus isEqualToString:@"待付款"]) {
        return 1;
    }
    else{
        return 2;
    }
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
    
    if ([self.model.orderstatus isEqualToString:@"待付款"]) {
        
        static NSString *cellIdentifier = @"MyorderDetailCell";
        MyorderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MyorderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=self.model;
        tableView.rowHeight=self.cellH1;
        return cell;
        
    }
    else{
        if (indexPath.section==0) {
            static NSString *cellIdentifier = @"MyorderDetailCell";
            MyorderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MyorderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.model=self.model;
            tableView.rowHeight=self.cellH1;
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"MyorderDetailTowCell";
            MyorderDetailTowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MyorderDetailTowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            tableView.rowHeight=FitRealValue(400);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.model=self.model;
            return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}
#pragma mark === click ===

-(void)tuikuanClick{
    
    
    
}
- (void)getOrderDetailInfoUrl {
    self.net.requestId=1001;
    [self.net Order_infoWithUid:[User getUserID] orderid:self.orderidStr ordersn:self.ordersnStr];
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
        //辅材列表
        float btnW=FitRealValue(200);
        float btnH=FitRealValue(60);
        float bottonH=FitRealValue(120);
        NSDictionary * bodyDic = result[@"body"];
        self.model=[MyorderDetailModel mj_objectWithKeyValues:bodyDic];
        if ([self.model.orderstatus isEqualToString:@"已失效"]) {
            self.bottomView.hidden=YES;
        }
        if ([self.model.orderstatus isEqualToString:@"订单成功"]) {
            self.bottomView.hidden=NO;
            self.bottomBtn1.frame=CGRectMake(ScreenWidth-LeftMargin*2-btnW, (bottonH-btnH)/2, btnW, btnH);
            [self.bottomBtn1 setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.bottomBtn1 addTarget:self action:@selector(tuikuanClick) forControlEvents:UIControlEventTouchUpInside];
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
