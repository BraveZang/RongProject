//
//  VideoCourseRangeCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "VideoCourseRangeCell.h"

@implementation VideoCourseRangeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0, FitRealValue(88), FitRealValue(80))];
    self.nameLab.backgroundColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.nameLab.font=[UIFont systemFontOfSize:14];
    self.nameLab.textAlignment=NSTextAlignmentCenter;
    self.nameLab.text=@"录播课";
    [self addSubview: self.nameLab];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLab.right, 0, FitRealValue(360), FitRealValue(80))];
    self.titleLab.backgroundColor=[MTool colorWithHexString:@"#FF6B6B"];
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.text=@"录播课";
    [self addSubview: self.titleLab];
    
    
    self.timeLab1=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-LeftMargin*2-FitRealValue(36)-FitRealValue(120), 0, FitRealValue(120), FitRealValue(80))];
    self.timeLab1.backgroundColor=[MTool colorWithHexString:@"##888888"];
    self.timeLab1.font=[UIFont systemFontOfSize:12];
    self.timeLab1.textAlignment=NSTextAlignmentRight;
    self.timeLab1.text=@"试看5分钟";
    self.timeLab1.hidden=YES;
    [self addSubview: self.timeLab1];
    
    self.playImg=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-LeftMargin-FitRealValue(36), (FitRealValue(80)-FitRealValue(36))/2, FitRealValue(36), FitRealValue(36))];
    [self.playImg setImage:[UIImage imageNamed:@"play_img"]];
    self.playImg.hidden=YES;
    [self addSubview: self.playImg];
    
}
-(void)setModel:(CourSerAngeModel *)model{
    
    self.nameLab.text=model.zjnum;
    self.titleLab.text=model.vname;
    if ([model.istry isEqualToString:@"1"]) {
        self.timeLab1.hidden=YES;
        self.playImg.hidden=YES;
    }
    else{
        self.timeLab1.hidden=NO;
        self.playImg.hidden=NO;
    }
}

@end
