//
//  NewLoadingView.m
//  RongPenProject
//
//  Created by zanghui  on 2020/9/14.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


- (void)dealloc {
//    NSLogFunction;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        [view setBackgroundColor:[UIColor blackColor]];
        view.userInteractionEnabled = NO;
        view.tag = 1992;
        [view setAlpha:0.4];
        [self addSubview:view];
        
        
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 107, 82)];
        
        [backView setCenter:self.center];
        
        [self addSubview:backView];
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 82)];
        [backImageView setImage:[UIImage imageNamed:@"loadingBG"]];
        
        [backView addSubview:backImageView];
        
        loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 46, 46)];
        [loadingImageView setImage:[UIImage imageNamed:@"loading"]];
        [loadingImageView setCenter:CGPointMake(backView.frame.size.width / 2, loadingImageView.center.y)];
        [backView addSubview:loadingImageView];
        
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 46, 46)];
        [topImageView setImage:[UIImage imageNamed:@"loadingTop"]];
        [topImageView setCenter:loadingImageView.center];
        [backView addSubview:topImageView];
        
        angle = 360.0;
        animationing = YES;
        
        [self loadingAnimation];
        
    }
    return self;
}

- (void)setLoadingViewAlpha:(BOOL)loadingViewAlpha{
    _loadingViewAlpha = loadingViewAlpha;
    if (loadingViewAlpha) {
        UIView *view = [self viewWithTag:1992];
        view.alpha = 0;
    }
}


- (void)loadingAnimation {
    if (!animationing) {
        return;
    }
    
    angle -= 90;
    if (angle <= 0) {
        angle = 360;
    }
    
    __weak typeof (loadingImageView) weakLoadingImageView = loadingImageView;
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [weakLoadingImageView setTransform:CGAffineTransformMakeRotation(angle * M_PI / 180.0)];
    } completion:^(BOOL finished) {
        if (animationing) {
            [weakSelf loadingAnimation];
        }
    }];
    
}

- (void)stopAnimation {
    animationing = NO;
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
