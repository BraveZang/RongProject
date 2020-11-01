//
//  TuiKuandetailVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import "TuiKuandetailVC.h"
#import "PayCell.h"
#import "danhaoCell.h"
#import "wuliuListVC.h"

@interface TuiKuandetailVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong)  UITableView                       *tableView;
@property (nonatomic, strong)  NetManager                        *net;
@property (nonatomic, strong)  UIButton                          *loginBtn;
@property (nonatomic, strong)  NSString                          *nameStr;
@property (nonatomic, strong)  NSString                          *mobileStr;
@property (nonatomic, strong)  NSString                          *adresStr;
@property (nonatomic, strong)  NSDictionary                      *wuliuDic;
@property (nonatomic, strong)  NSString                          *danhaoStr;


@end

@implementation TuiKuandetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.rightImgBtn.hidden=NO;
    self.toptitle.text=@"退款";
    self.toptitle.hidden=NO;
    
    UILabel*titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, FitRealValue(128))];
    titleLab.backgroundColor=[MTool colorWithHexString:@"#F96C65"];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.font=[UIFont systemFontOfSize:14];
    titleLab.text=@"   请将设备完整包装";
    [self.view addSubview:titleLab];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, titleLab.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight- titleLab.bottom-FitRealValue(120)) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(20,ScreenHeight-FitRealValue(104), ScreenWidth-40, 44);
    [self.loginBtn setBackgroundColor:[MTool colorWithHexString:@"#F96C65"]];
    [self.loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    self.loginBtn.cornerRadius=20;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self getUrl1001];
}
-(void)setOrderidStr:(NSString *)orderidStr{
    _orderidStr=orderidStr;
}
-(void)setTkorderidStr:(NSString *)tkorderidStr{
    
    _tkorderidStr=tkorderidStr;
}
#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return 3;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 4;
    }
    else{
    return 1;
    }
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
      
    if (indexPath.section==0) {
    static NSString *cellIdentifier = @"PayCellkk";
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.iconImg.hidden=YES;
    cell.lineView.hidden=YES;
    cell.bgView.frame=CGRectMake(10, 0, ScreenWidth-20, FitRealValue(88));
    cell.bgView.cornerRadius=5;
    cell.nameLab.frame=CGRectMake(10,0,FitRealValue(170),FitRealValue(88));
    cell.payTitleLab.frame=CGRectMake(cell.nameLab.right+5,0, 200, FitRealValue(88));
    cell.nameLab.font=[UIFont systemFontOfSize:14];
    cell.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    cell.payTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
    tableView.rowHeight=FitRealValue(84);
        if (indexPath.row==0) {
            cell.nameLab.font=[UIFont systemFontOfSize:16];
            cell.nameLab.text=@"退货信息";
            cell.payTitleLab.hidden=YES;
            
        }
        if (indexPath.row==1) {
            cell.nameLab.text=@"收件人：";
            cell.payTitleLab.text=self.nameStr;
            
        }
        if (indexPath.row==2) {
            cell.nameLab.text=@"联系电话：";
            cell.payTitleLab.text=self.mobileStr;

        }
        if (indexPath.row==3) {
            cell.nameLab.text=@"地址：";
            cell.payTitleLab.text=self.adresStr;

        }
        return cell;
    }
    else  if (indexPath.section==1){
        
        static NSString *cellIdentifier = @"PayCellkkll";
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.iconImg.hidden=YES;
        cell.lineView.hidden=YES;
        cell.bgView.frame=CGRectMake(10, 0, ScreenWidth-20, FitRealValue(88));
        cell.bgView.cornerRadius=5;
        cell.nameLab.frame=CGRectMake(10,0,FitRealValue(140),FitRealValue(88));
        cell.payTitleLab.frame=CGRectMake(cell.nameLab.right+5,0, 200, FitRealValue(88));

        cell.nameLab.font=[UIFont systemFontOfSize:14];
        cell.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
        cell.payTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
        tableView.rowHeight=FitRealValue(84);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.nameLab.font=[UIFont systemFontOfSize:16];
        cell.nameLab.text=@"物流公司";
        cell.payTitleLab.hidden=YES;
        cell.rightLab.hidden=NO;
        if (self.wuliuDic!=nil) {
        cell.rightLab.text=self.wuliuDic[@"names"];
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"danhaoCelllll";
         danhaoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         if (cell == nil) {
             cell = [[danhaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
         }
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
         tableView.rowHeight=FitRealValue(260);
        cell.textfieldStrBlock = ^(NSString * _Nonnull str) {
            
            self.danhaoStr=str;
        };

        return cell;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==1) {
        self.net.requestId=1002;
        [self.net Order_kdcompanyWithNoParam];
    }
    
}
-(void)getUrl1001{
    self.net.requestId=1001;
    [self.net Order_tuiaddressWithNoParam];
}
-(void)sureButClick{
    self.net.requestId=1003;
    [self.net Order_submitorderWithUid:[User getUserID] orderid:self.orderidStr tkorderid:self.tkorderidStr companyid:self.wuliuDic[@"id"] kdorder:self.danhaoStr];
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
            NSDictionary*bodyDic=result[@"body"];
            self.nameStr=bodyDic[@"name"];
            self.mobileStr=bodyDic[@"mobile"];
            self.adresStr=bodyDic[@"address"];
            [self.tableView reloadData];
        }
         if (request.requestId==1002) {
            
             NSArray*bodyAry=result[@"body"];
             wuliuListVC*vc=[wuliuListVC new];
             vc.ary=bodyAry;
             vc.ItemBlock = ^(NSDictionary * _Nonnull dic) {
                 self.wuliuDic=dic;
                 [self.tableView reloadData];
             };
             [self.navigationController pushViewController:vc animated:YES];
         }
         if (request.requestId==1003) {
             
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
