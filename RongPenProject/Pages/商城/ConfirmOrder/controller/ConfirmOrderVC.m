//
//  ConfirmOrderVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "ConfirmOrderVC.h"
#import "ShopAdressCell.h"
#import "ConfirmOrderVCCell.h"

@interface ConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong) NetManager                  *net;
@property (nonatomic, strong) UITableView                 *tableView;
@property (nonatomic, strong) UILabel                     *moneyLab;


@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"确认订单";
    
}
-(void)createTableView{
    
    self.view.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(LeftMargin, SafeAreaTopHeight+24*SCREEN_WIDTH/750, SCREEN_WIDTH-LeftMargin*2, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight-50-24*SCREEN_WIDTH/750) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView*footview=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight-50, SCREEN_WIDTH, 50)];
    footview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:footview];
    
    self.moneyLab=[MTool quickCreateLabelWithleft:0 top:0 width:SCREEN_WIDTH-250*SCREEN_WIDTH/750 heigh:50 title:@"¥:1000"];
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF403C"];
    self.moneyLab.font=[UIFont systemFontOfSize:16];
    [footview addSubview: self.moneyLab];
    
    UIButton*payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame=CGRectMake(self.moneyLab.right, 0,250*SCREEN_WIDTH/750,50);
    [payBtn setBackgroundColor:[MTool colorWithHexString:@"#FF9B9B"]];
    [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [payBtn addTarget:self action:@selector(payBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview: payBtn];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后的cell的高度
    if (indexPath.row==0) {
        return 184*SCREEN_WIDTH/750;
    }
    else{
    return 230*SCREEN_WIDTH/750;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString *CellIdentifier = @"ShopAdressCell";
        ShopAdressCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ShopAdressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
//        cell.adressmodel=self.adressmodel;
        return cell;
    }
    else{
    static NSString *CellIdentifier = @"ConfirmOrderVCCell";
    ConfirmOrderVCCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ConfirmOrderVCCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
         return cell;
    }
   }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row==0) {
//        AddressManagerViewController*vc=[[AddressManagerViewController alloc]init];
//        vc.hidesBottomBarWhenPushed=YES;
//        vc.vctag=100;
//        vc.backBlock = ^(AddressModel * _Nonnull model) {
//            self.adressmodel=model;
//            [self.tableview reloadData];
//        };
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//
}
@end
