//
//  CheckpointListCell.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "CheckpointListCell.h"

@implementation CheckpointListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)createUI{
    
    float viewX=FitRealValue(76);
    float viewW=ScreenWidth-viewX*2;
    float viewH=FitRealValue(560);
    float imgH=FitRealValue(88);
    float playH=FitRealValue(80);
    
    if (IS_IPAD) {
        viewH=viewH*2/3;
        playH=playH*2/3;
        imgH=imgH*2/3;
        
    }
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(viewX, 0, viewW, viewH)];
    bgView.cornerRadius=5;
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    UIImageView*titleImg=[[UIImageView alloc]initWithFrame:CGRectMake((viewW-imgH)/2, 20, imgH, imgH)];
    [titleImg setImage:[UIImage imageNamed:@""]];
    titleImg.backgroundColor=[UIColor redColor];
    [bgView addSubview:titleImg];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, titleImg.bottom+FitRealValue(24),viewW,20)];
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
    
    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame=CGRectMake(LeftMargin,self.starView.bottom+FitRealValue(60), viewW-LeftMargin*2, 40);
    [self.playBtn setBackgroundColor:TITLECOLOR];
    [self.playBtn setTitle:@"重新闯关" forState:UIControlStateNormal];
    [self.playBtn setTitleColor:[MTool colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    self.playBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bgView addSubview:self.playBtn];
    
}
@end
