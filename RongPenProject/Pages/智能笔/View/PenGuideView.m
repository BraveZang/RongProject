//
//  PenGuideView.m
//  RongPenProject
//
//  Created by mac on 7.11.20.
//

#import "PenGuideView.h"



@implementation PenGuideView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatPenGuideView];
    }
    return self;
}


- (void)creatPenGuideView{
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(15,44,ScreenWidth-30,25);
    _titleLab.backgroundColor =[UIColor orangeColor];
    [self addSubview:_titleLab];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"1.打开荣知智能笔开关"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC" size: 22],NSForegroundColorAttributeName: [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0]}];
    _titleLab.attributedText = string;
    
    
    self.explainLab = [[UILabel alloc] init];
    _explainLab.frame = CGRectMake(28,_titleLab.bottom,255,22);
    _explainLab.numberOfLines = 0;
    [self addSubview:_explainLab];

    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"长按尾部开关，直至LED指示灯闪烁"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];

    [string1 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.000000]} range:NSMakeRange(0, 9)];

    [string1 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:209/255.0 green:46/255.0 blue:46/255.0 alpha:1.000000]} range:NSMakeRange(9, 6)];

    [string1 addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.000000]} range:NSMakeRange(15, 2)];

    _explainLab.attributedText = string1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
