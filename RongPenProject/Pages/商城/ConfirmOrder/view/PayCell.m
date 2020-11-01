//
//  PayCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import "PayCell.h"

@implementation PayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    self.backgroundColor=[MTool colorWithHexString:@"f8f8f8"];
    return self;
}
-(void)initView{
   
    float viewH=FitRealValue(178);
    float viewW=ScreenWidth-LeftMargin*2;
    float labH=FitRealValue(90);
    float imgW=FitRealValue(40);
    
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0,viewW,FitRealValue(88))];
    self.nameLab.font=[UIFont systemFontOfSize:12];
    self.nameLab.text=@"支付方式";
    self.nameLab.textColor=[MTool colorWithHexString:@"#666666"];
    [self.bgView addSubview:self.nameLab];
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.nameLab.bottom, viewW, 1)];
     self.lineView.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [self.bgView addSubview: self.lineView];

    self.iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin,  self.lineView.bottom+(labH-imgW)/2, imgW, imgW)];
    [self.iconImg setImage:[UIImage imageNamed:@"payimg"]];
    [self.bgView addSubview:self.iconImg];
    
    self.payTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.iconImg.right+5,  self.lineView.bottom, 200, labH)];
    self.payTitleLab.font=[UIFont systemFontOfSize:12];
    self.payTitleLab.text=@"支付宝付款";
    self.payTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
    [self.bgView addSubview:self.payTitleLab];
    
    self.rightLab=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-LeftMargin-22-200,0, 200, labH)];
    self.rightLab.font=[UIFont systemFontOfSize:12];
    self.rightLab.textAlignment=NSTextAlignmentRight;
    self.rightLab.text=@"请选择";
    self.rightLab.hidden=YES;
    self.rightLab.textColor=[MTool colorWithHexString:@"#888888"];
    [self.bgView addSubview:self.rightLab];

}
@end
