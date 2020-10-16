//
//  ShopIndexCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/10.
//

#import "ShopIndexCell.h"

@interface ShopIndexCell ()

@property(nonatomic,strong)UIImageView  *heardImg;
@property(nonatomic,strong)UIImageView  *tagImg;
@property(nonatomic,strong)UILabel      *nameLab;
@property(nonatomic,strong)UILabel      *monryLab;

@end
@implementation ShopIndexCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        float viewH=FitRealValue(212*2);
        float viewW=(ScreenWidth-30)/2;
        float ImgH=FitRealValue(140*2);
//        if (IS_IPAD) {
//            viewH=viewW*2/3;
//            ImgH=ImgH*2/3;
//        }
        UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,viewW , viewH)];
        bgView.backgroundColor=[UIColor whiteColor];
        bgView.cornerRadius=5;
        [self addSubview:bgView];
        
        self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,viewW,ImgH)];
        [self.heardImg setImage:[UIImage imageNamed:@"fenxiangiconxiaoxi"]];
        [bgView addSubview:self.heardImg];
        
        self.tagImg=[[UIImageView alloc]initWithFrame:CGRectMake(viewW-72,ImgH-20,72,20)];
        [self.tagImg setImage:[UIImage imageNamed:@"tagimg"]];
        self.tagImg.hidden=YES;
        [self.heardImg addSubview:self.tagImg];
        
        
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(5, self.heardImg.bottom+20, viewW-10,FitRealValue(30))];
        self.nameLab.font=[UIFont systemFontOfSize:14];
        self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
        [bgView addSubview:self.nameLab];
        
        self.monryLab=[[UILabel alloc]initWithFrame:CGRectMake(5, self.nameLab.bottom+10*SCREEN_WIDTH/750, viewW-10, FitRealValue(30))];
        self.monryLab.font=[UIFont systemFontOfSize:14];
        self.monryLab.textColor=[MTool colorWithHexString:@"#D12E2E"];
        [bgView addSubview:self.monryLab];
        
        
    }
    return self;
}
-(void)setModel:(ShopIndexModel *)model{
    
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:model.fmimg]];
    self.nameLab.text=model.name;
    self.monryLab.text=[NSString stringWithFormat:@"¥%@",model.sprice];
    
    if ([model.type isEqualToString:@"商品"]) {
        self.tagImg.hidden=YES;
    }
    else{
        self.tagImg.hidden=NO;
    }
}
@end
