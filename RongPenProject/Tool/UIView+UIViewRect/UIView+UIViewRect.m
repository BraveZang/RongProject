//
//  UIView+UIViewRect.m
//  SanMuZhuangXiu
//
//  Created by apple on 2019/7/5.
//  Copyright © 2019 Darius. All rights reserved.
//

#import "UIView+UIViewRect.h"

@implementation UIView (UIViewRect)


- (void)setFrameX:(CGFloat)x {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height)];
}

- (void)setFrameY:(CGFloat)y {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height)];
}

- (void)setFrameXAndY:(CGFloat)x y:(CGFloat)y {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(x, y, rect.size.width, rect.size.height)];
}

- (void)setFrameWidth:(CGFloat)width {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height)];
}

- (void)setFrameHeight:(CGFloat)height {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height)];
}

- (void)setFrameWidthAndHeight:(CGFloat)width height:(CGFloat)height {
    CGRect rect = self.frame;
    [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, width, height)];
}

- (CGFloat) top
{
    return self.frame.origin.y;
}
- (CGFloat) left
{
    return self.frame.origin.x;
}

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}


@end
