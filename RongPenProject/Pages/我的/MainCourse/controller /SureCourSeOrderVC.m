//
//  SureCourSeOrderVC.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/31.
//

#import "SureCourSeOrderVC.h"
#import "ShopAdressCell.h"
#import "ConfirmOrderVCCell.h"
#import "Shop_qrorderModel.h"
#import "PriceCell.h"
#import "PayCell.h"
#import "AddressModel.h"
#import "AddAdressVC.h"
#import "SureCourseDeatilodel.h"
#import "CourseTimeCell.h"
#import "AdressListVC.h"


#import <AlipaySDK/AlipaySDK.h>


@interface SureCourSeOrderVC ()<UITableViewDelegate,UITableViewDataSource,NetManagerDelegate>

@property (nonatomic, strong) NetManager                  *net;
@property (nonatomic, strong) UITableView                 *tableView;
@property (nonatomic, strong) UILabel                     *moneyLab;
@property (nonatomic, strong) SureCourseDeatilodel        *model;
@property (nonatomic, strong) AddressModel                *adressModel;
@property (nonatomic, strong) NSArray                     *guigeAry;
@property (nonatomic, strong) NSArray                     *timeAry;
@property (nonatomic, assign) NSInteger                   IndextimeSelect;


@end
@implementation SureCourSeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftImgBtn.hidden=NO;
    self.toptitle.hidden=NO;
    self.toptitle.text=@"确认订单";
    self.topview.hidden=NO;
    self.IndextimeSelect=1000;
    self.timeAry=[NSArray array];
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
    
    self.moneyLab=[MTool quickCreateLabelWithleft:LeftMargin top:0 width:SCREEN_WIDTH-250*SCREEN_WIDTH/750 heigh:50 title:@"¥:1000"];
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF403C"];
    self.moneyLab.font=[UIFont systemFontOfSize:16];
    [footview addSubview: self.moneyLab];
    
    UIButton*payBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame=CGRectMake(ScreenWidth-150-LeftMargin,5,150,40);
    //    [payBtn setBackgroundColor:[MTool colorWithHexString:@"#FF9B9B"]];
    //    [payBtn setImage:[UIImage imageNamed:@"payBtn_img"] forState:UIControlStateNormal];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"payBtn_img"]  forState:UIControlStateNormal];
    [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [payBtn addTarget:self action:@selector(payBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview: payBtn];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.timeAry.count==0) {
        return 1;
    }
    else{
        if (section==2) {
            return self.timeAry.count+1;
        }
        else{
            return 1;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.timeAry.count==0) {
        return 4;
    }
    else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后的cell的高度
    
    if (self.timeAry.count==0) {
        if (indexPath.section==0) {
            return 164*SCREEN_WIDTH/750;
        }
        else if (indexPath.section==1) {
            return 370*SCREEN_WIDTH/750;
        }
        else if (indexPath.section==2) {
            return FitRealValue(84)*3;
        }
        else{
            return FitRealValue(254);
        }
    }
    else{
        
        if (indexPath.section==0) {
            return 164*SCREEN_WIDTH/750;
        }
        else if (indexPath.section==1) {
            return 368*SCREEN_WIDTH/750;
        }
        else if (indexPath.section==2) {
            return FitRealValue(84);
        }
        else if (indexPath.section==3) {
            return FitRealValue(260);
        }
        else if (indexPath.section==4) {
            return FitRealValue(254);
        }
        else{
            return FitRealValue(84)*2;
        }
        
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.timeAry.count==0) {
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
        else if (indexPath.section==(1+2)) {//支付方式
            
            static NSString *CellIdentifier = @"PayCell";
            PayCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }
        else if (indexPath.section==(1+1)) {//运费
            
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
            
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"共计:%@", self.model.total]];
            [placeholder addAttribute:NSForegroundColorAttributeName value:[MTool colorWithHexString:@"#FF8D8D"] range:NSMakeRange(3,self.model.total.length)];
            [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(3,self.model.total.length)];
            cell.totalmoneyLab.attributedText = placeholder;
            //            cell.totalmoneyLab.text=[NSString stringWithFormat:@"共计:%@",self.model.total];
            //            cell.totalmoneyLab.text=@"aaaaaaaaa";
            //            cell.totalmoneyLab.textColor=[UIColor redColor];
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
                //                self.guigeAry=ary;
                //                [self creatActionSheet];
            };
            NSDictionary*listDic=self.model.lists;
            cell.dic=listDic;
            return cell;
        }
    }else{
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ShopAdressCell111";
            ShopAdressCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[ShopAdressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.adressmodel=self.adressModel;
            return cell;
        }
        else if (indexPath.section==(1+1)) {//选择上课时间
            
            static NSString *CellIdentifier = @"PayCell1111";
            CourseTimeCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[CourseTimeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (indexPath.row==0) {
                cell.nameLab.text=@"选择上课时间";
                cell.selectBtn.hidden=YES;
            }
            else{
                NSDictionary*dic=self.timeAry[indexPath.row-1];
                cell.nameLab.text=dic[@"weeks"];
            }
            if (self.IndextimeSelect+1==indexPath.row) {
                [cell.selectBtn setImage:[UIImage imageNamed:@"quan_btn_s"] forState:UIControlStateNormal];
            }
            else{
                [cell.selectBtn setImage:[UIImage imageNamed:@"quan_btn"] forState:UIControlStateNormal];
                
            }
            cell.Block = ^{
                self.IndextimeSelect=indexPath.row-1;
                NSDictionary*dic=self.timeAry[indexPath.row-1];

                self.net.requestId=1007;
                [self.net Course_settimeWithUid:[User getUserID] Id:self.idStr Time:[NSString stringWithFormat:@"%@",dic[@"id"]]];
            };
            
            return cell;
        }
        else if (indexPath.section==(1+3)) {//支付方式
            
            static NSString *CellIdentifier = @"PayCell1111";
            PayCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }
        else if (indexPath.section==(1+2)) {//运费
            
            NSString *CellIdentifier =@"PriceCell211111";
            PriceCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[PriceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.nameLab.text=@"商品价格";
            cell.moneyLab.text=self.model.total;
            cell.nameLab1.text=@"运费";
            cell.moneyLab1.text=self.model.kdprice;
            
            NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"共计:%@", self.model.total]];
            [placeholder addAttribute:NSForegroundColorAttributeName value:[MTool colorWithHexString:@"#FF8D8D"] range:NSMakeRange(3,self.model.total.length)];
            [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(3,self.model.total.length)];
            cell.totalmoneyLab.attributedText = placeholder;
            return cell;
        }
        
        else{
            
            NSString *CellIdentifier =[NSString stringWithFormat:@"ConfirmOrder1111%ld",indexPath.section];
            ConfirmOrderVCCell*cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[ConfirmOrderVCCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.colorBlock = ^(NSArray * _Nonnull ary) {
                self.guigeAry=ary;
                [self creatActionSheet];
            };
            NSDictionary*listDic=self.model.lists;
            cell.dic=listDic;
            return cell;
        }
        
        
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
        
        AdressListVC*vc=[AdressListVC new];
        vc.Block = ^(AddressModel * _Nonnull model) {
            self.adressModel=model;
            self.net.requestId=1004;
            [self.net Shop_xzaddressWithUid:[User getUserID] Orderid:self.idStr Addressid:model.id];
        };
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

-(void)payBtnclick{
    
    if (self.timeAry.count==0) {
        self.net.requestId=1003;
        [self.net Pay_buyWithUid:[User getUserID] Ordersn:self.ordersnStr];
    }
    else{
        self.net.requestId=1003;
        [self.net Pay_zbpayUid:[User getUserID] Ordersn:self.ordersnStr];
    }
}
-(void)getUrlData{
    
    self.net.requestId=1001;
    User*user=[User getUser];
    [self.net Course_qrorderWithId:_idStr Uid:user.uid Ordersn:_ordersnStr];
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
            self.model=[SureCourseDeatilodel mj_objectWithKeyValues:bodyDic];
            NSDictionary*adressDic=self.model.shouhuo;
            self.adressModel=[AddressModel mj_objectWithKeyValues:adressDic];
            NSDictionary*timediC=self.model.lists;
            self.timeAry=timediC[@"timelist"];
            self.moneyLab.text=[NSString stringWithFormat:@"¥:%@",self.model.total];
            [self.tableView reloadData];
        }
        if (request.requestId==1002) {//
            
        }
        if (request.requestId==1003) {//
            NSString*bodyStr=result[@"body"];
            [[AlipaySDK defaultService] payOrder:bodyStr
                                      fromScheme:@"none.RongPenProject1"
                                        callback:^(NSDictionary *resultDic) {
                NSLog(@"-------%@", resultDic);
            }];
            
        }
        if (request.requestId==1004) {//
            
            [self.tableView reloadData];
            
        }
        if (request.requestId==1007) {//
                   
            [self.tableView reloadData];
                   
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

