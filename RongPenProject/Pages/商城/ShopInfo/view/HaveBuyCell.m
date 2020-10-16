//
//  HaveBuyCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "HaveBuyCell.h"
@interface HaveBuyCell ()
@end
@implementation HaveBuyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    
    
    float viewH=FitRealValue(90);
    float bgViewH=FitRealValue(60);
    float bgViewW=ScreenWidth-30;
    float viewW=ScreenWidth;
    //        if (IS_IPAD) {
    //            viewH=viewW*2/3;
    //            ImgH=ImgH*2/3;
    //        }
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(15,(viewH-bgViewH)/2 ,bgViewW , bgViewH)];
    self.bgView.backgroundColor=[MTool colorWithHexString:@"#FF8181"];
    self.bgView.cornerRadius=5;
    [self addSubview: self.bgView];
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, bgViewW-30,FitRealValue(60))];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    [ self.bgView addSubview:self.nameLab];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(15,0, bgViewW-30, FitRealValue(60))];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textAlignment=NSTextAlignmentRight;
    self.moneyLab.textColor=[MTool colorWithHexString:@"#212121"];
    [ self.bgView addSubview:self.moneyLab];
    
}
-(void)setSelect:(BOOL)select{
    
    _select=select;
    
    if (self.select==YES) {
        // 如果是当前cell
        self.bgView.borderWidth=1;
        self.bgView.backgroundColor=[MTool colorWithHexString:@"#FF9B9B"];
        self.bgView.borderColor=[MTool colorWithHexString:@"#FF4E4E"];
    }else{
        self.bgView.borderWidth=0;
        self.bgView.backgroundColor=[MTool colorWithHexString:@"#EFEFEF"];    }
}
@end
