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
    _titleLab.textColor = hexColor(212121);
    _titleLab.font = [UIFont systemFontOfSize:22];
    [self addSubview:_titleLab];

    _titleLab.text = @"1.打开荣知智能笔开关";
    
    
    self.explainLab = [[UILabel alloc] init];
    _explainLab.frame = CGRectMake(28,_titleLab.bottom+10,ScreenWidth-28,22);
    _explainLab.font = [UIFont systemFontOfSize:16];

    [self addSubview:_explainLab];
    _explainLab.textColor = hexColor(666666);
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString: @"长按尾部开关，直至LED指示灯闪烁"];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[MTool colorWithHexString:@"#D12E2E"] range:NSMakeRange(9,6)];
    _explainLab.attributedText = placeholder;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
