//
//  DictationListCell.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "DictationListCell.h"

@interface DictationListCell()


@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UILabel               *contentLab;
@property (strong,nonatomic) UIButton              *playBtn;
@property (nonatomic,strong) UIProgressView        *progressView;

@end

@implementation DictationListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)createUI{
    
    float viewW=ScreenWidth-LeftMargin*2;
    float viewH=FitRealValue(300);
    float playH=FitRealValue(70);

    if (IS_IPAD) {
        viewH=viewH*2/3;
        playH=playH*2/3;
    }
    UIView*bgView=[[UIView alloc]initWithFrame:CGRectMake(LeftMargin, 0, viewW, viewH)];
    bgView.cornerRadius=5;
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 15,viewW-LeftMargin*2,15)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:14];
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    [bgView addSubview:self.titleLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, self.titleLab.bottom+FitRealValue(80),viewW-LeftMargin*2,15)];
    self.contentLab.font=[UIFont boldSystemFontOfSize:12];
    self.contentLab.textColor=[MTool colorWithHexString:@"#F65555"];
    [bgView addSubview:self.contentLab];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(LeftMargin, self.contentLab.bottom+20,viewW-LeftMargin*2-playH, 14)];
    
    //滑轮左边颜色，如果设置了左边的图片就不会显示
    _progressView.progressTintColor = [MTool colorWithHexString:@"#F65555"];
    //滑轮右边颜色，如果设置了左边的图片就不会显示
    _progressView.trackTintColor = [MTool colorWithHexString:@"#F1F1F1"];
    _progressView.progressViewStyle = UIProgressViewStyleBar;
    [bgView addSubview:self.progressView];
    
    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame=CGRectMake(viewW-LeftMargin-playH, (viewH-playH)/2, playH, playH);
    [self.playBtn setImage:[UIImage imageNamed:@"play_img"] forState:UIControlStateNormal];
    [bgView addSubview:self.playBtn];

}


- (void)setUnitModle:(UnitModel *)unitModle{
    self.titleLab.text=unitModle.name;
    self.contentLab.text=[NSString stringWithFormat:@"已完成%@/%@",unitModle.mypassnum,unitModle.gqcount];
    
    _progressView.progress = unitModle.mypassnum.floatValue/unitModle.gqcount.floatValue;

}

@end
