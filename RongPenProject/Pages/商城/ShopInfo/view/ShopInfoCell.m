//
//  ShopInfoCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import "ShopInfoCell.h"

@implementation ShopInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    
    float viewH=FitRealValue(90);
    float viewW=ScreenWidth;
    //        if (IS_IPAD) {
    //            viewH=viewW*2/3;
    //            ImgH=ImgH*2/3;
    //        }
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, viewW-30,FitRealValue(90))];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
    [ self addSubview:self.nameLab];
    
    self.moneyLab=[[UILabel alloc]initWithFrame:CGRectMake(15,0, viewW-30, FitRealValue(90))];
    self.moneyLab.font=[UIFont systemFontOfSize:14];
    self.moneyLab.textAlignment=NSTextAlignmentRight;
    self.moneyLab.textColor=[MTool colorWithHexString:@"#FF8181"];
    [ self addSubview:self.moneyLab];
    
    
}

@end
