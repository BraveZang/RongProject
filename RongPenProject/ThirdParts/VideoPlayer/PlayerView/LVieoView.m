//
//  LVieoView.m
//  BearUp
//
//  Created by Tebuy on 16/10/26.
//  Copyright © 2016年 Lee2Go. All rights reserved.
//

#import "LVieoView.h"

#define kToolViewHieght 40
@interface LVieoView ()
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UISlider *slider;//用来现实视频的播放进度

@property (nonatomic, assign) BOOL isShowToolView;//是否显示工具栏
@property (nonatomic, strong) UIButton *playOrPause;//播放暂停按钮

@property (nonatomic, strong) NSTimer *showTimer;//显示工具栏时间
@property (nonatomic, strong) NSTimer *progressTimer;//进度条计时器
@property (nonatomic, strong) UILabel *timerLabel;//播放时间
@property (nonatomic, strong) UILabel *allTimeLabel;//总时间
@property (nonatomic, strong) UIButton *bigPlayBtn;//中间播放按钮
@property (nonatomic, strong) UIView *coverView;//遮盖版
@property (nonatomic, strong) UIView *toolView;//工具栏
@end

@implementation LVieoView

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.center = self.center;
        _coverView.bounds = CGRectMake(0, 0, 100, 100);
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
        [self addSubview:_coverView];
    }
    return _coverView;
}
- (NSTimer *)progressTimer{
    if (!_progressTimer) {
        _progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    }
    return _progressTimer;
}
//懒加载进度条
- (UISlider *)slider{
    if (!_slider) {
        _slider.backgroundColor = [UIColor whiteColor];
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(110, 0, 200, kToolViewHieght)];
        //设置slider原点已经最大点最小点图片
        [_slider setThumbImage:[UIImage imageNamed:@"videothumb"] forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slider;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playTap:)];
        [self addGestureRecognizer:tap];
        
        UIButton *ReplayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ReplayBtn setImage:[UIImage imageNamed:@"chongshe"] forState:UIControlStateNormal];
        ReplayBtn.center = self.coverView.center;
        ReplayBtn.frame = CGRectMake(0, 0, 100, 100);
        [ReplayBtn addTarget:self action:@selector(rePlayClick) forControlEvents:UIControlEventTouchUpInside];
        [self.coverView addSubview:ReplayBtn];
        
        self.player = [[AVPlayer alloc]init];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        [self.playerLayer setFrame:self.bounds];
        self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:self.playerLayer];
        //工具栏
        self.toolView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - kToolViewHieght, self.bounds.size.width, kToolViewHieght)];
        self.toolView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        [self addSubview:self.toolView];
        [self bringSubviewToFront:self.toolView];
        //播放按钮
        self.playOrPause = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playOrPause setImage:[UIImage imageNamed:@"videoplay"] forState:UIControlStateNormal];
        [self.playOrPause setImage:[UIImage imageNamed:@"videopause"] forState:UIControlStateSelected];
        self.playOrPause.contentMode = UIViewContentModeCenter;
        [self.playOrPause addTarget:self action:@selector(playOrPauseClick:) forControlEvents:UIControlEventTouchUpInside];
        self.playOrPause.frame = CGRectMake(0, 0, 30, kToolViewHieght);
        [self.toolView addSubview:self.playOrPause];
        
        [self.toolView addSubview:self.slider];
        
        self.timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 40, kToolViewHieght)];
        self.timerLabel.font = [UIFont systemFontOfSize:10.0];
        self.timerLabel.textColor = [UIColor whiteColor];
        [self.toolView addSubview:self.timerLabel];
        
        self.allTimeLabel  =[[UILabel alloc]initWithFrame:CGRectMake(70, 0, 40, kToolViewHieght)];
        self.allTimeLabel.font = [UIFont systemFontOfSize:10.0];
        self.allTimeLabel.textColor = [UIColor whiteColor];
        [self.toolView addSubview:self.allTimeLabel];
        
        self.bigPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bigPlayBtn setImage:[UIImage imageNamed:@"videoplay"] forState:UIControlStateNormal];
        [self.bigPlayBtn addTarget:self action:@selector(playOrPauseBigClick:) forControlEvents:UIControlEventTouchUpInside];
        self.bigPlayBtn.frame = self.bounds;
        self.bigPlayBtn.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.bigPlayBtn];
        
        
        self.coverView.hidden = YES;
        self.toolView.alpha = 0;
        self.isShowToolView = NO;
        self.playOrPause.selected = NO;
    }
    return self;
}

- (void)touchDown:(UISlider *)slider{
    // 按下去 移除监听器
    [self removeProgressTimer];
    [self removeShowTime];
}
- (void)valueChange:(UISlider *)slider{
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * slider.value;
    self.timerLabel.text = [self timeToStringWithTimeInterval:currentTime];
}
- (void)touchUpInside:(UISlider *)slider{
    [self addProgressTimer];
    //计算当前slider拖动对应的播放时间
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * slider.value;
    // seekToTime:播放跳转到当前播放时间
    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self toolViewShow];
}
- (void)toolViewShow{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(toolViewHide) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop]addTimer:self.showTimer forMode:NSRunLoopCommonModes];
}
- (void)toolViewHide{
    self.isShowToolView = !self.isShowToolView;
    [UIView animateWithDuration:0.5 animations:^{
        self.toolView.alpha = 0;
    }];
    NSLog(@"工具栏隐藏");
}
//移除定时器
- (void)removeShowTime{
    [self.showTimer invalidate];
    self.showTimer = nil;
}
//播放按钮方法
- (void)playOrPauseClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (!btn.selected) {
        self.toolView.alpha = 0.8;
        [self removeShowTime];
        [self.player pause];
        [self removeProgressTimer];
    }else{
        [self toolViewShow];
        [self.player play];
        [self addProgressTimer];
    }
}
//中间播放按钮的方法
- (void)playOrPauseBigClick:(UIButton *)btn{
    btn.hidden = YES;
    self.playOrPause.selected = YES;
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
    [self addProgressTimer];
}
//slider定时器添加
- (void)addProgressTimer{
    [self progressTimer];
}
//移除slider定时器
- (void)removeProgressTimer{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
//更新slider和time
- (void)updateProgressInfo{
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    NSTimeInterval durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
    
    self.timerLabel.text = [self timeToStringWithTimeInterval:currentTime];
    self.allTimeLabel.text = [self timeToStringWithTimeInterval:durationTime];
    self.slider.value = CMTimeGetSeconds(self.player.currentTime)/CMTimeGetSeconds(self.player.currentItem.duration);
    
    if (self.slider.value == 1) {
        [self removeProgressTimer];
        self.coverView.hidden = NO;
    }
}
//转换播放时间和总时间的方法
-(NSString *)timeToStringWithTimeInterval:(NSTimeInterval)interval;
{
    NSInteger Min = interval / 60;
    NSInteger Sec = (NSInteger)interval % 60;
    NSString *intervalString = [NSString stringWithFormat:@"%02ld:%02ld",Min,Sec];
    return intervalString;
}
//手势点击
- (void)playTap:(UITapGestureRecognizer *)tap{
    //未播放状态，点击view会直接播放
    if (self.player.status == AVPlayerStatusUnknown) {
        [self playOrPauseClick:self.playOrPause];
        return;
    }
    //记录工具栏的是否隐藏
    self.isShowToolView = !self.isShowToolView;
    if (self.isShowToolView) {
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.alpha = 0.8;
        }];
        //工具栏的按钮为播放状态是，添加计时器，5秒之后自动隐藏
        if (self.playOrPause.selected) {
            [self toolViewShow];
        }
    }else{
        [self removeShowTime];
        [UIView animateWithDuration:0.5 animations:^{
            self.toolView.alpha = 0;
        }];
    }
}
- (void)setVideoUrl:(NSString *)videoUrl{
    _videoUrl = videoUrl;
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoUrl]];
}
//重播按钮
- (void)rePlayClick{
    self.slider.value = 0;
    [self touchUpInside:self.slider];
    self.coverView.hidden = YES;
    [self playOrPauseBigClick:self.bigPlayBtn];
}
@end
