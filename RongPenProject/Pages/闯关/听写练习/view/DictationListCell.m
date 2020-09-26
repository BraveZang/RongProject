//
//  DictationListCell.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "DictationListCell.h"

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
    self.titleLab.text=@"Unit 1 Classroom";
    [bgView addSubview:self.titleLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, self.titleLab.bottom+FitRealValue(80),viewW-LeftMargin*2,15)];
    self.contentLab.font=[UIFont boldSystemFontOfSize:12];
    self.contentLab.textColor=[MTool colorWithHexString:@"#F65555"];
    self.contentLab.text=@"已完成3/10";
    [bgView addSubview:self.contentLab];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(LeftMargin, self.contentLab.bottom+20,viewW-LeftMargin*2-playH, 14)];
    _progressView.progress = 0.3;// 设置初始值0~1
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

@end
