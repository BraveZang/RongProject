//
//  ConfirmOrderVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "ConfirmOrderVC.h"
#import "ShopAdressCell.h"
#import "ConfirmOrderVCCell.h"
#import "Shop_qrorderModel.h"
#import "PriceCell.h"
#import "PayCell.h"
#import "AddressModel.h"
#import "AddAdressVC.h"


@interface ConfirmOrderVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong) NetManager                  *net;
@property (nonatomic, strong) UITableView                 *tableView;
@property (nonatomic, strong) UILabel                     *moneyLab;
@property (nonatomic, strong) Shop_qrorderModel           *model;
@property (nonatomic, strong) AddressModel                *adressModel;
@property (nonatomic, strong) NSArray                     *guigeAry;


@end
@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"确认订单";
    self.topview.hidden=NO;
    [self createTableView];
    [self getUrlData];
    
}
-(void)createTableView{
    
    self.view.backgroundColor=[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(LeftMargin, SafeAreaTopHeight, SCREEN_WIDTH-LeftMargin*2, SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor=[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
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
    

        return 1;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3+self.model.lists.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后的cell的高度
    NSArray*listsAry=self.model.lists;
    if (indexPath.section==0) {
        return 164*SCREEN_WIDTH/750;
    }
    else if (indexPath.section==3+self.model.lists.count-1) {
        return FitRealValue(178);
    }
    else if (indexPath.section==3+self.model.lists.count-2) {
        return FitRealValue(84)*2;
    }
    
    else{
        NSDictionary*dic=listsAry[indexPath.section-1];
        NSString*tipStr=dic[@"tip"];
        if ([tipStr isEqualToString:@"赠品"]) {
            
            return FitRealValue(260);
            
        }
        else{
            return 368*SCREEN_WIDTH/750;
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray*listsAry=self.model.lists;
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"ShopAdressCell";
        ShopAdressCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ShopAdressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
                cell.adressmodel=self.adressModel;
        return cell;
    }
    else if (indexPath.section==(self.model.lists.count+2)) {//支付方式
        
        static NSString *CellIdentifier = @"PayCell";
        PayCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else if (indexPath.section==(self.model.lists.count+1)) {//运费
   
            NSString *CellIdentifier =@"PriceCell2";
            PriceCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[PriceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.nameLab.text=@"商品价格";
            cell.moneyLab.text=self.model.total;
            cell.nameLab1.text=@"运费";
            cell.moneyLab1.text=self.model.kdprice;
            
            return cell;
    }
    
    else{
        NSString *CellIdentifier =[NSString stringWithFormat:@"ConfirmOrder%ld",indexPath.section];
        ConfirmOrderVCCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ConfirmOrderVCCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.colorBlock = ^(NSArray * _Nonnull ary) {
            self.guigeAry=ary;
            [self creatActionSheet];
        };
        NSDictionary*listDic=listsAry[indexPath.section-1];
        cell.dic=listDic;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (indexPath.row==0) {
            AddAdressVC*vc=[[AddAdressVC alloc]init];
            vc.hidesBottomBarWhenPushed=YES;
            vc.VCtag=1;
//            vc.backBlock = ^(AddressModel * _Nonnull model) {
//                self.adressmodel=model;
//                [self.tableview reloadData];
//            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    
}

-(void)creatActionSheet {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择规格" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<self.guigeAry.count; i++) {
        NSDictionary*dic=self.guigeAry[i];
        UIAlertAction *action=[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",dic[@"name"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [actionSheet addAction:action];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [actionSheet addAction:action3];
    
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
-(void)setIdStr:(NSString *)idStr{
    
    _idStr=idStr;
}
-(void)setOrdersnStr:(NSString *)ordersnStr{
    
    _ordersnStr=ordersnStr;
}
-(void)getUrlData{
    
    self.net.requestId=1001;
    User*user=[User getUser];
    [self.net Shop_qrorderWithUid:user.uid Id:_idStr Ordersn:_ordersnStr];
}

- (void)requestDidFinished:(NetManager *)request result:(NSMutableDictionary *)result{
    
    NSDictionary*heardDic=result[@"head"];
    NSDictionary*bodyDic=result[@"body"];
    
    if ([heardDic[@"res_code"]intValue]!=0002) {
        
        [DZTools showNOHud:result[@"res_msg"] delay:2];
        return;
    }
    else{
        if (request.requestId==1001) {//
            
            self.model=[Shop_qrorderModel mj_objectWithKeyValues:bodyDic];
            NSDictionary*adressDic=self.model.shouhuo;
            self.adressModel=[AddressModel mj_objectWithKeyValues:adressDic];
            
            [self.tableView reloadData];
        }
        if (request.requestId==1002) {//
            
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
