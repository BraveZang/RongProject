//
//  PriceCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import "PriceCell.h"

@implementation PriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
    
    float viewH=FitRealValue(84);
    float viewW=ScreenWidth-LeftMargin*2;

    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH*2)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0,viewW,viewH)];
    self.nameLab.font=[UIFont systemFontOfSize:12];
    self.nameLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:self.nameLab];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(viewW-LeftMargin-300,0,300,viewH)];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textAlignment=NSTextAlignmentRight;
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF665B"];
    [bgView addSubview:self.moneyLab];
    
    self.nameLab1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,self.nameLab.bottom,viewW,viewH)];
    self.nameLab1.font=[UIFont systemFontOfSize:12];
    self.nameLab1.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:self.nameLab1];
    
    self.moneyLab1=[[UILabel alloc]initWithFrame:CGRectMake(viewW-LeftMargin-300,self.nameLab.bottom,300,viewH)];
    self.moneyLab1.font=[UIFont systemFontOfSize:14];
    self.moneyLab1.textAlignment=NSTextAlignmentRight;
    self.moneyLab1.textColor=[MTool colorWithHexString:@"#FF665B"];
    [bgView addSubview:self.moneyLab1];
}

@end
