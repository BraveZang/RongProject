//
//  CheckpointResultVC.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "CheckpointResultVC.h"

@interface CheckpointResultVC ()

@end

@implementation CheckpointResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBA(243, 245, 248, 1);
    self.leftImgBtn.hidden=NO;
    self.topview.hidden=NO;
    [self createUI];
}
-(void)createUI{
    
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=ScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-FitRealValue(140)-30;
    float imgH=FitRealValue(180);
    if (IS_IPAD) {
        imgH=imgH*2/3;
    }
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin,SafeAreaTopHeight+30,viewW, viewH)];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.cornerRadius=5;
    [self.view addSubview:bgView];
    
    self.titleImg=[[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgH)/2, imgH, imgH, imgH)];
    [self.titleImg setImage:[UIImage imageNamed:@"resule_img_1"]];
    [bgView addSubview:self.titleImg];
    
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, self.titleImg.bottom+FitRealValue(24),viewW,20)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:16];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    self.titleLab.text=@"关卡一";
    [bgView addSubview:self.titleLab];
    
    self.timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.frame=CGRectMake(0, self.titleLab.bottom+FitRealValue(50), viewW, 16);
    [self.timeBtn setImage:[UIImage imageNamed:@"play_img"] forState:UIControlStateNormal];
    [self.timeBtn setTitle:@"用时：3‘24" forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[MTool colorWithHexString:@"#F65555"] forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [bgView addSubview:self.timeBtn];
    
    
    self.starView = [[HYBStarEvaluationView alloc] initWithFrame:CGRectMake(LeftMargin*1.5, self.timeBtn.bottom+FitRealValue(60),viewW-LeftMargin*3,26) numberOfStars:5 isVariable:NO];
    self.starView.actualScore = 4;
    self.starView.fullScore = 5;
    self.starView.isContrainsHalfStar = YES;
    [bgView addSubview:self.starView];
    
    
    self.allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.allBtn.frame=CGRectMake(LeftMargin,self.starView.bottom+FitRealValue(90), (viewW-LeftMargin*4)/2, 40);
    [self.allBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allBtn setTitle:@"全部听写" forState:UIControlStateNormal];
    self.allBtn.borderWidth=0.5;
    self.allBtn.cornerRadius=16;
    self.allBtn.borderColor=[MTool colorWithHexString:@"#F65555"];
    [self.allBtn setTitleColor:[MTool colorWithHexString:@"#F65555"] forState:UIControlStateNormal];

    self.allBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bgView addSubview:self.allBtn];
    
    self.nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(self.allBtn.right+LeftMargin*2,self.starView.bottom+FitRealValue(90), (viewW-LeftMargin*4)/2, 40);
    self.nextBtn.cornerRadius=16;
    [self.nextBtn setBackgroundColor:TITLECOLOR];
    [self.nextBtn setTitle:@"重新闯关" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[MTool colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bgView addSubview:self.nextBtn];
}

@end
