//
//  MainSetCell.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import "MainSetCell.h"

@implementation MainSetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    float viewW=(ScreenWidth-LeftMargin*2)/2;
    float viewH=FitRealValue(110);
    if (IS_IPAD) {
        viewH=viewH*2/3;
    }
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, 0,viewW,viewH)];
    self.titleLab.font=[UIFont boldSystemFontOfSize:14];
//    _titleLab.backgroundColor = [UIColor greenColor];
    self.titleLab.textColor=[MTool colorWithHexString:@"#212121"];
    [self.contentView addSubview:self.titleLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(_titleLab.right, 0,viewW -30,viewH)];
    self.contentLab.font=[UIFont boldSystemFontOfSize:12];
    self.contentLab.textAlignment=NSTextAlignmentRight;
//    self.contentLab.backgroundColor = [UIColor redColor];
    self.contentLab.textColor=[MTool colorWithHexString:@"#888888"];
    [self.contentView addSubview:self.contentLab];
}

@end
