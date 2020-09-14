//
//  MAlertView.m
//  SanMuZhuangXiu
//
//  Created by apple on 2019/7/5.
//  Copyright © 2019 Darius. All rights reserved.
//

#import "MAlertView.h"

@implementation MAlertView
@synthesize delegate;


- (void)awakeFromNib
{
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    
    label.font = [UIFont systemFontOfSize:15.0f];
    [label setBackgroundColor:[UIColor clearColor]];
    
    CGRect frame = self.frame;
    frame.origin.y = (768-50)/2;
    frame.origin.x = (1024-200)/2;
    self.frame = frame;
    [self setAlpha:0.6];
}

- (void)showWithTitle:(NSString *)title inView:(UIView *)view
{
    [view addSubview:self];
    
    label.text = title;
    CGFloat h = [MTool sizeWithText:label.text font:label.font constrainedToSize:CGSizeMake(200, 500)].height + 10;
    h = MAX(h, 40);
    
    CGRect frame = self.frame;
    frame.size.height = h;
    frame.origin.y = (view.frame.size.height-h)/2;
    frame.origin.x = (view.frame.size.width-200)/2;
    self.frame = frame;
    
    CGRect lFrame = label.frame;
    lFrame.size.height = h;
    label.frame = lFrame;
    
    //[self setFrameWidth:self.frame.size.width + 10];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self remove];
    });
    
}

- (void)remove
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished){
        
        if ([delegate respondsToSelector:@selector(malertviewDidMiss)])
        {
            [delegate malertviewDidMiss];
        }
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
