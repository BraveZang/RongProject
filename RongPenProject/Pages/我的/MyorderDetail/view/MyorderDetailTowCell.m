//
//  MyorderDetailTowCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "MyorderDetailTowCell.h"

@implementation MyorderDetailTowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initTableView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}

- (void)initTableView {
    float viewH=FitRealValue(400);
    float cellH=FitRealValue(100);
    if (IS_IPAD) {
        cellH=cellH*2/3;
        viewH=viewH*2/3;
    }
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(LeftMargin, 0, SCREEN_WIDTH-LeftMargin*2,viewH) style:UITableViewStylePlain];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = cellH;
    [self addSubview:self.tableView];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+FitRealValue(200), 0, ScreenWidth-(LeftMargin+FitRealValue(200)), cellH)];
    self.contentLab.font=[UIFont systemFontOfSize:14];
    self.contentLab.textColor=[MTool colorWithHexString:@"#666666"];
    
}


#pragma mark UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    float viewH=FitRealValue(400);
    float cellH=FitRealValue(100);
    if (IS_IPAD) {
        cellH=cellH*2/3;
        viewH=viewH*2/3;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    [cell addSubview:self.contentLab];
    if (indexPath.row==0) {
        cell.textLabel.text=@"订单信息";
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        
    }
    if (indexPath.row==1) {
        cell.textLabel.text=@"订单编号:";
        if (self.str1.length>0) {
            UILabel* contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+FitRealValue(200), 0, ScreenWidth-(LeftMargin+FitRealValue(200)), cellH)];
            contentLab.font=[UIFont systemFontOfSize:14];
            contentLab.textColor=[MTool colorWithHexString:@"#666666"];
            [cell addSubview:contentLab];
            contentLab.text=self.str1;
            
        }
    }
    if (indexPath.row==2) {
        cell.textLabel.text=@"支付宝交易号:";
        if (self.str2.length>0) {
            UILabel* contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+FitRealValue(200), 0, ScreenWidth-(LeftMargin+FitRealValue(200)), cellH)];
            contentLab.font=[UIFont systemFontOfSize:14];
            contentLab.textColor=[MTool colorWithHexString:@"#666666"];
            [cell addSubview:contentLab];
            contentLab.text=self.str2;
        }


    }
    if (indexPath.row==3) {
        cell.textLabel.text=@"付款时间:";
        if (self.str3.length>0) {
            UILabel* contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin+FitRealValue(200), 0, ScreenWidth-(LeftMargin+FitRealValue(200)), cellH)];
            contentLab.font=[UIFont systemFontOfSize:14];
            contentLab.textColor=[MTool colorWithHexString:@"#666666"];
            [cell addSubview:contentLab];
            contentLab.text=self.str3;
            
        }
    }
    
    
    return cell;
}
-(void)setModel:(MyorderDetailModel *)model{
    _model=model;
    self.str1=model.ordersn;
    self.str2=model.alipayno;
    self.str3=model.paytime;
    [self.tableView reloadData];
}
@end
