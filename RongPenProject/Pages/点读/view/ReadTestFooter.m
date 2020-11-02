//
//  ReadTestFooter.m
//  RongPenProject
//
//  Created by mac on 1.11.20.
//

#import "ReadTestFooter.h"
@interface ReadTestFooter()

@property (nonatomic, strong) UIButton  *helpBtn;
@property (nonatomic, strong) UIButton  *playBtn;
@end

@implementation ReadTestFooter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatReadInfoFooterView];
    }
    return self;
}

- (void)creatReadInfoFooterView{
    
    self.helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_helpBtn setImage:[UIImage imageNamed:@"Read_guide_Icon"] forState:UIControlStateNormal];
    _helpBtn.frame = CGRectMake(APP_WIDTH_6S(15.0), APP_HEIGHT_6S(7.0), APP_HEIGHT_6S(166.0), APP_HEIGHT_6S(42.0));
    [self addSubview:_helpBtn];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setImage:[UIImage imageNamed:@"Read_play_Icon"] forState:UIControlStateNormal];
    _playBtn.frame = CGRectMake(APP_WIDTH_6S(13.0) + _helpBtn.right, APP_HEIGHT_6S(7.0), APP_HEIGHT_6S(166.0), APP_HEIGHT_6S(42.0));
    [self addSubview:_playBtn];
    
    ;
    
}


- (void)helpBtnClick{
    if (self.penWriteblock) {
        self.penWriteblock();
    }
}
- (void)playBtnClick{
    if (self.phoneWriteblock) {
        self.phoneWriteblock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
