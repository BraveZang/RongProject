//
//  CourseVideoCollCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//

#import "CourseVideoCollCell.h"

@interface CourseVideoCollCell ()

@property(nonatomic,strong)UIImageView  *heardImg;
@property(nonatomic,strong)UIImageView  *tagImg;
@property(nonatomic,strong)UILabel      *nameLab;
@property(nonatomic,strong)UILabel      *monryLab;

@end
@implementation CourseVideoCollCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        float viewH=FitRealValue(280);
        float viewW=(ScreenWidth-45)/2;
        float ImgH=FitRealValue(220);
        float tagImgH=FitRealValue(60);

        if (IS_IPAD) {
            viewH=viewW*2/3;
            ImgH=ImgH*2/3;
        }
        UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,viewW , viewH)];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        
        self.heardImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,viewW,ImgH)];
        [self.heardImg setImage:[UIImage imageNamed:@"fenxiangiconxiaoxi"]];
        [bgView addSubview:self.heardImg];
        
        self.tagImg=[[UIImageView alloc]initWithFrame:CGRectMake((viewW-tagImgH)/2,(ImgH-tagImgH)/2,tagImgH,tagImgH)];
        [self.tagImg setImage:[UIImage imageNamed:@"viedo_play"]];
        [self.heardImg addSubview:self.tagImg];
        
        
        self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(5, self.heardImg.bottom, viewW,FitRealValue(60))];
        self.nameLab.font=[UIFont systemFontOfSize:14];
        self.nameLab.textColor=[MTool colorWithHexString:@"#212121"];
        [bgView addSubview:self.nameLab];
        
        
    }
    return self;
}

-(void)setModel:(CourseVideoModel *)model{
    
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:model.videofm]];
    self.nameLab.text=model.name;
    
}
-(void)setGoodeModel:(GoodsModel *)goodeModel{
    
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:goodeModel.videofm]];
    self.nameLab.text=goodeModel.goodsname;
}
@end
