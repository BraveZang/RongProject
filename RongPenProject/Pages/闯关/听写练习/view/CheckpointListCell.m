//
//  CheckpointListCell.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "CheckpointListCell.h"
@interface CheckpointListCell()


@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UIImageView            *timeIMG;

@property (strong,nonatomic) UILabel               *timeLab;

@property (strong,nonatomic) UIButton              *playBtn;


@end
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
    [titleImg setImage:[UIImage imageNamed:@"guanka_Icon"]];
    [bgView addSubview:titleImg];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, titleImg.bottom+FitRealValue(24),viewW,20)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:16];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    [bgView addSubview:self.titleLab];
    
    
    self.timeIMG=[[UIImageView alloc]initWithFrame:CGRectMake((viewW-156)/2, _titleLab.bottom+FitRealValue(50), 18 , 18)];
    [_timeIMG setImage:[UIImage imageNamed:@"guanka_time_Icon"]];
//    [bgView addSubview:_timeIMG];
    
    self.timeLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _titleLab.bottom+FitRealValue(50),viewW,20)];
    self.timeLab.font=[UIFont boldSystemFontOfSize:16];
    self.timeLab.textAlignment=NSTextAlignmentCenter;
    self.timeLab.textColor=[MTool colorWithHexString:@"#212121"];
   
    [bgView addSubview:self.timeLab];
    
    
    self.starView = [[HYBStarEvaluationView alloc] initWithFrame:CGRectMake(LeftMargin*1.5, self.timeLab.bottom+FitRealValue(60),viewW-LeftMargin*3,26) numberOfStars:5 isVariable:NO];
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

- (void)setModel:(gkModel *)model{
    self.titleLab.text= model.gqname;
    
    if (![model.start isEqualToString:@"0"]) {
        self.timeLab.text = [NSString stringWithFormat:@"用时：%@",model.timelen];
        self.timeLab.textColor = [UIColor colorWithHexColorString:@"F65555"];
        [_timeIMG setImage:[UIImage imageNamed:@"guanka_time_Icon"]];

    }else{
        self.timeLab.text = @"尚未通关";
        self.timeLab.textColor = [UIColor colorWithHexColorString:@"909090"];
        [_timeIMG setImage:[UIImage imageNamed:@"guanka_ lock_Icon"]];

    }
    self.starView.actualScore = model.start.integerValue;

}

@end
