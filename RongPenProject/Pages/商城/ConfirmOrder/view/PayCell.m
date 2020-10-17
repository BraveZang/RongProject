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
    
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,0,viewW,FitRealValue(88))];
    self.nameLab.font=[UIFont systemFontOfSize:12];
    self.nameLab.text=@"支付方式";
    self.nameLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:self.nameLab];
    
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.nameLab.bottom, viewW, 1)];
    lineView.backgroundColor=[MTool colorWithHexString:@"#F3F3F3"];
    [bgView addSubview:lineView];

    UIImageView*iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, lineView.bottom+(labH-imgW)/2, imgW, imgW)];
    [iconImg setImage:[UIImage imageNamed:@"payimg"]];
    [bgView addSubview:iconImg];
    
    UILabel*payTitleLab=[[UILabel alloc]initWithFrame:CGRectMake(iconImg.right+5, lineView.bottom, 200, labH)];
    payTitleLab.font=[UIFont systemFontOfSize:12];
    payTitleLab.text=@"支付宝付款";
    payTitleLab.textColor=[MTool colorWithHexString:@"#666666"];
    [bgView addSubview:payTitleLab];

}
@end
