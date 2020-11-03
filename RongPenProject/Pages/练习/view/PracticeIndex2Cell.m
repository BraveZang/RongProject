//
//  PracticeIndex2Cell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/4.
//

#import "PracticeIndex2Cell.h"


@interface PracticeIndex2Cell()
@property (nonatomic,strong)UIImageView    *img;
@property (nonatomic,strong)UILabel        *titleLab;
@property (nonatomic,strong)UILabel        *Lab1;
@property (nonatomic,strong)UILabel        *Lab2;
@property (nonatomic,strong)UILabel        *Lab3;

@property (nonatomic,strong) UIProgressView        *progressView;

@end
@implementation PracticeIndex2Cell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}
-(void)initView{
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=ScreenHeight-FitRealValue(80)*2-SafeAreaBottomHeight-SafeAreaTopHeight-49;
    float btnW=FitRealValue(320);
    float btnH=FitRealValue(80);
  
    
    self.img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,viewW , viewH)];
    [self.img setImage:[UIImage imageNamed:@"bglll"]];
    [self addSubview:self.img];
  
    UIButton*chakanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    chakanBtn.frame=CGRectMake((viewW-btnW)/2, viewH-50-btnH, btnW, btnH);
    [chakanBtn setBackgroundImage:[UIImage imageNamed:@"gobuy"] forState:UIControlStateNormal];
    [self addSubview: chakanBtn];
    [chakanBtn addTarget:self action:@selector(chakanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
 
}
-(void)chakanBtnClick{
    [MTool showText:@"敬请期待" showTime:2];
}
@end
