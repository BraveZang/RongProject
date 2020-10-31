//
//  VideoTitleCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import "VideoTitleCell.h"

@implementation VideoTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{

    self.nameLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 10, FitRealValue(88), FitRealValue(36))];
    self.nameLab.backgroundColor=rgb(253, 173, 70);
    self.nameLab.font=[UIFont systemFontOfSize:9];
    self.nameLab.textAlignment=NSTextAlignmentCenter;
    self.nameLab.text=@"录播课";
    [self addSubview:self.nameLab];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(self.nameLab.right+5, 10, ScreenWidth-(self.nameLab.right+5)-LeftMargin, FitRealValue(36))];
    self.titleLab.textColor=[UIColor blackColor];
    self.titleLab.font=[UIFont systemFontOfSize:16];
    [self addSubview: self.titleLab];
    
    self.contentLab1=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,self.titleLab.bottom+10, ScreenWidth-LeftMargin*2, FitRealValue(16))];
    self.contentLab1.textColor=[MTool colorWithHexString:@"#888888"];
    self.contentLab1.font=[UIFont systemFontOfSize:10];
    [self addSubview: self.contentLab1];
    
    self.contentLab2=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,  self.contentLab1.bottom+5, ScreenWidth-LeftMargin*2, FitRealValue(16))];
    self.contentLab2.textColor=[MTool colorWithHexString:@"#888888"];
    self.contentLab2.font=[UIFont systemFontOfSize:10];
    [self addSubview: self.contentLab2];
    
    
    self.npriceLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin,  self.contentLab2.bottom+10, ScreenWidth-LeftMargin*2, FitRealValue(40))];
    self.npriceLab.textColor=[MTool colorWithHexString:@"#FF5448"];
    self.npriceLab.font=[UIFont systemFontOfSize:14];
    [self addSubview: self.npriceLab];

}
-(void)setModel:(MainCourseDetailModel *)model{
    
    self.titleLab.text=model.name;
    self.contentLab1.text=[NSString stringWithFormat:@"课程有效期：%@",@"1年"];
    self.contentLab2.text=[NSString stringWithFormat:@"课程章节：%@",model.range];
    self.npriceLab.text=[NSString stringWithFormat:@"¥%@",model.sprice];
}
@end
