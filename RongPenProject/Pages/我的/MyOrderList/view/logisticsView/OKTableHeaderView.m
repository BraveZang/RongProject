//
//  OKTableHeaderView.m
//  OKLogisticsInformation
//
//  Created by Oragekk on 16/7/9.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "OKTableHeaderView.h"
#import "ShopAdressCell.h"
#import "OKConfigFile.h"

@interface OKTableHeaderView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView *goodsPic;
@property (nonatomic,strong) UILabel *type;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *comLabel;
@property (strong, nonatomic) YYLabel *phoneLabel;
@property (nonatomic,strong) UIWebView *phoneCallWebView;
@property (nonatomic, strong) UITableView                 *tableView;

@end
#define GRAY_TITLECOLOR 0x9D9D9D
@implementation OKTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self createTableView];
    }
    return self;
}
-(void)createTableView{
    
    self.backgroundColor=[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FitRealValue(356)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor=[UIColor colorWithRed:243/255.0 green:245/255.0 blue:248/255.0 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];

}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==1) {
        return 2;
    }
    else{
        return 1;
    }
        
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中之后的cell的高度
  
    if (indexPath.section==0) {
        return 164*SCREEN_WIDTH/750;
    }
  
    else{
    
      return 66*SCREEN_WIDTH/750;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"ShopAdressCell";
        ShopAdressCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[ShopAdressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
   
    else{
        static NSString *CellIdentifier =@"ConfirmOrderssss";
        UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        if (indexPath.row==0) {
            cell.textLabel.text=[NSString stringWithFormat:@"快递名称：%@",self.company];
        }
        else{
            cell.textLabel.text=[NSString stringWithFormat:@"快递单号：%@",self.number];
            
        }
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
-(void)setNumber:(NSString *)number{
    _number=number;
    [self.tableView reloadData];

}
-(void)setCompany:(NSString *)company{
    _company=company;
    [self.tableView reloadData];
}
@end
