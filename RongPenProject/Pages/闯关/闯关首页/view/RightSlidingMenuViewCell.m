//
//  RightSlidingMenuViewCell.m
//  RongPenProject
//
//  Created by 路面机械网  on 2020/9/21.
//

#import "RightSlidingMenuViewCell.h"

@implementation RightSlidingMenuViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        float viewH=FitRealValue(60);
        float viewW=ScreenWidth-FitRealValue(230);
        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(LeftMargin, FitRealValue(18), 5, (viewH-FitRealValue(36)))];
        self.yellowView.backgroundColor = [MTool colorWithHexString:@"#FF5448"];
        self.yellowView.hidden=YES;
        [self.contentView addSubview:self.yellowView];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(self.yellowView.right+10,0,viewW-self.yellowView.right,viewH)];
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textColor =[MTool colorWithHexString:@"#282828"];
//        self.name.highlightedTextColor = [MTool colorWithHexString:@"#FF6E1D"];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}

@end
