//
//  ReadInfoItemView.m
//  RongPenProject
//
//  Created by czg on 2020/10/26.
//

#import "ReadInfoItemView.h"

@interface ReadInfoItemView ()

@property (nonatomic, strong) UIButton  *helpBtn;
@property (nonatomic, strong) UIButton  *playBtn;
@property (nonatomic, strong) UIButton  *readBtn;
@property (nonatomic, strong) UIButton  *connectBtn;


@end

@implementation ReadInfoItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        [self creatReadInfoFooterView];
    }
    return self;
}

- (void)creatReadInfoFooterView{
    
    self.helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_helpBtn setImage:[UIImage imageNamed:@"Read_guide_Icon"] forState:UIControlStateNormal];
    _helpBtn.frame = CGRectMake(APP_WIDTH_6S(20.0), 0, APP_HEIGHT_6S(46.0), APP_HEIGHT_6S(46.0));
    [self addSubview:_helpBtn];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setImage:[UIImage imageNamed:@"Read_pause_Icon"] forState:UIControlStateNormal];
    _playBtn.frame = CGRectMake(APP_WIDTH_6S(20.0) + _helpBtn.right, 0, APP_HEIGHT_6S(46.0), APP_HEIGHT_6S(46.0));
    [self addSubview:_playBtn];
    
    self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_readBtn addTarget:self action:@selector(readBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_readBtn setImage:[UIImage imageNamed:@"Read_edit_Icon"] forState:UIControlStateNormal];
    _readBtn.frame = CGRectMake(APP_WIDTH_6S(20.0) + _playBtn.right, 0, APP_HEIGHT_6S(46.0), APP_HEIGHT_6S(46.0));
    [self addSubview:_readBtn];
    
    self.connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_connectBtn addTarget:self action:@selector(readBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_connectBtn setImage:[UIImage imageNamed:@"Read_connect_Icon"] forState:UIControlStateNormal];
    _connectBtn.frame = CGRectMake(KSCREEN_WIDTH - APP_WIDTH_6S(65.0), 0, APP_WIDTH_6S(70.0), APP_HEIGHT_6S(46.0));
    [self addSubview:_connectBtn];
    
}


- (void)helpBtnClick{
    if (self.helpBtnblock) {
        self.helpBtnblock();
    }
}
- (void)playBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_playBtn setImage:[UIImage imageNamed:@"Read_play_Icon"] forState:UIControlStateNormal];
        if (self.pauseBtnblock) {
            self.pauseBtnblock();
        }
    }else{
        [_playBtn setImage:[UIImage imageNamed:@"Read_pause_Icon"] forState:UIControlStateNormal];
        if (self.playBtnblock) {
            self.playBtnblock();
        }
        
    }
    
    
    
    
}
- (void)readBtnClick{
    if (self.readBtnblock) {
        self.readBtnblock();
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
