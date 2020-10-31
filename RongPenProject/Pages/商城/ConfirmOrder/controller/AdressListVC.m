//
//  AdressListVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/31.
//

#import "AdressListVC.h"
#import "AddressModel.h"
#import "ShopAdressCell.h"
#import "AddressManagerListCell.h"
#import "AddAdressVC.h"

@interface AdressListVC ()<NetManagerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    UIView* NoDataView;
}

@property (strong, nonatomic)  UITableView        *tableView;
@property (strong, nonatomic)  NSMutableArray     *dataArray;
@property (nonatomic)          NSInteger          page;
@property (nonatomic, strong)  NetManager         *net;
@property (nonatomic, strong)  UIButton           *addadressBtn;

@end

@implementation AdressListVC


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self getUrlData1001];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"地址管理";
    self.rightImgBtn.hidden=NO;
    [self.rightImgBtn setImage:nil forState:UIControlStateNormal];
    [self.rightImgBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [self.rightImgBtn setTitleColor:[MTool colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [self.rightImgBtn addTarget:self action:@selector(rightBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,  SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
    
    //无数据时候的显示
    NoDataView=[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaTopHeight-SafeAreaBottomHeight-300*SCREEN_WIDTH/750)];
    NoDataView.backgroundColor=[UIColor whiteColor];
    UIImageView*img=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-662*SCREEN_WIDTH/750)/2, 300*SCREEN_WIDTH/750, 662*SCREEN_WIDTH/750, 398*SCREEN_WIDTH/750)];
    [img setImage:[UIImage imageNamed:@"img_wudizhi"]];
    [NoDataView addSubview:img];
    
    UILabel*lab=[MTool quickCreateLabelWithleft:0 top:img.bottom width:SCREEN_WIDTH heigh:50*SCREEN_WIDTH/750 title:@"暂无地址信息"];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[MTool colorWithHexString:@"999999"];
    [NoDataView addSubview:lab];
    
    [self getUrlData1001];
}
#pragma mark-- function
- (void)rightBarButtonItemClicked
{
    AddAdressVC *viewController = [AddAdressVC new];
    viewController.VCtag=1;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)getUrlData1001
{
    self.net.requestId=1001;
    [self.net Member_addressWithUid:[User getUserID]];
    
}
#pragma mark - Function

#pragma mark--tableview deleteGate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        UIView *backgroundImageView = NoDataView;
        self.tableView.backgroundView = backgroundImageView;
        self.tableView.backgroundView.contentMode = UIViewContentModeCenter;
    } else {
        self.tableView.backgroundView = nil;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 180*SCREEN_WIDTH/750;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"AddressManagerListCell";
    AddressManagerListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[AddressManagerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    AddressModel *model=self.dataArray[indexPath.row];
    cell.model=model;
    cell.editBlock = ^(AddressModel * _Nonnull model) {
        AddAdressVC *viewController = [AddAdressVC new];
        viewController.VCtag=2;
        viewController.address_id=model.id;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_vctag==100) {
//        AddressModel *model=self.dataArray[indexPath.row];
//        self.backBlock(model);
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
    
}
-(void)setVctag:(NSInteger)vctag{
//    _vctag=vctag;
}
#pragma mark === NetManagerDelegate ===

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    NSDictionary*code=result[@"head"];
    if ([code[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:code[@"res_msg"] delay:2];
        return;
    }
    else{
        if (self.net.requestId==1001) {
            NSArray*ary=result[@"body"];
            
            if (ary.count>0) {
                self.dataArray=[NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *Dict in ary) {
                    AddressModel *model=[AddressModel mj_objectWithKeyValues:Dict];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
            }
            
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
