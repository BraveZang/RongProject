//
//  UIView.m
//  UXKit
//
//  Created by OranWu on 13-5-8.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "UIView+.h"

@implementation UIView(Additions)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}


-(void)setWidth:(CGFloat)width{

    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (id)initWithIOS7Frame:(CGRect)frame{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >=7) frame.origin.y = frame.origin.y + 20;
    self = [self initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1 /* full rotation*/ ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)rotateWithAngle:(CGFloat)angel animateDuration:(CGFloat)duration{
    CGAffineTransform swingTransform = CGAffineTransformIdentity;
    swingTransform = CGAffineTransformRotate(swingTransform, angel);
    
    [UIView animateWithDuration:duration animations:^{
        self.transform = swingTransform;
    }];
}

- (void)setScale:(float)scale{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width*scale, self.frame.size.height*scale)];
}

- (void)setRightTop:(CGPoint)origin Scale:(float)scale{
    [self setFrame:CGRectMake(origin.x - self.frame.size.width*scale, origin.y, self.frame.size.width*scale, self.frame.size.height*scale)];
}

- (void)setOrigin:(CGPoint)origin Scale:(float)scale{
    [self setFrame:CGRectMake(origin.x, origin.y, self.frame.size.width*scale, self.frame.size.height*scale)];
}

- (void)setCenter:(CGPoint)center Scale:(float)scale{
    [self setFrame:CGRectMake(center.x - self.frame.size.width*scale/2, center.y-self.frame.size.height*scale/2, self.frame.size.width*scale, self.frame.size.height*scale)];
}

- (void)addImage:(UIImage*)image atPoint:(CGPoint)point{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.origin = point;
    [self addSubview:imageView];
}

- (void)removeAllSubviews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)drawCircleAtCenterPoint:(CGPoint)center radius:(float)radius fill:(BOOL)isFill{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextAddArc(context, center.x, center.y, radius, M_PI, -M_PI, 0);
    if(isFill)
        CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
}

- (NSArray *)animationArrayWithAngle:(double)angle{
    NSArray *animationArray = @[
                                [NSNumber numberWithDouble:0.54],
                                [NSNumber numberWithDouble:2.84],
                                [NSNumber numberWithDouble:2.95],
                                [NSNumber numberWithDouble:2.71],
                                [NSNumber numberWithDouble:2.82],
                                [NSNumber numberWithDouble:2.75],
                                [NSNumber numberWithDouble:2.39],
                                [NSNumber numberWithDouble:2.73],
                                [NSNumber numberWithDouble:2.6],
                                [NSNumber numberWithDouble:2.35],
                                [NSNumber numberWithDouble:2.44],
                                [NSNumber numberWithDouble:2.38],
                                [NSNumber numberWithDouble:2.18],
                                [NSNumber numberWithDouble:2.26],
                                [NSNumber numberWithDouble:2.21],
                                [NSNumber numberWithDouble:2.02],
                                [NSNumber numberWithDouble:2.09],
                                [NSNumber numberWithDouble:2.03],
                                [NSNumber numberWithDouble:1.86],
                                [NSNumber numberWithDouble:1.92],
                                [NSNumber numberWithDouble:1.87],
                                [NSNumber numberWithDouble:1.71],
                                [NSNumber numberWithDouble:1.77],
                                [NSNumber numberWithDouble:1.71],
                                [NSNumber numberWithDouble:1.57],
                                [NSNumber numberWithDouble:1.61],
                                [NSNumber numberWithDouble:1.57],
                                [NSNumber numberWithDouble:1.43],
                                [NSNumber numberWithDouble:1.47],
                                [NSNumber numberWithDouble:1.42],
                                [NSNumber numberWithDouble:1.29],
                                [NSNumber numberWithDouble:1.33],
                                [NSNumber numberWithDouble:1.29],
                                [NSNumber numberWithDouble:1.17],
                                [NSNumber numberWithDouble:1.2],
                                [NSNumber numberWithDouble:1.16],
                                [NSNumber numberWithDouble:1.05],
                                [NSNumber numberWithDouble:1.08],
                                [NSNumber numberWithDouble:1],
                                [NSNumber numberWithDouble:0.97],
                                [NSNumber numberWithDouble:0.96],
                                [NSNumber numberWithDouble:0.92],
                                [NSNumber numberWithDouble:0.83],
                                [NSNumber numberWithDouble:0.85],
                                [NSNumber numberWithDouble:0.81],
                                [NSNumber numberWithDouble:0.73],
                                [NSNumber numberWithDouble:0.74],
                                [NSNumber numberWithDouble:0.71],
                                [NSNumber numberWithDouble:0.64],
                                [NSNumber numberWithDouble:0.65],
                                [NSNumber numberWithDouble:0.61],
                                [NSNumber numberWithDouble:0.55],
                                [NSNumber numberWithDouble:0.56],
                                [NSNumber numberWithDouble:0.53],
                                [NSNumber numberWithDouble:0.47],
                                [NSNumber numberWithDouble:0.47],
                                [NSNumber numberWithDouble:0.45],
                                [NSNumber numberWithDouble:0.39],
                                [NSNumber numberWithDouble:0.4],
                                [NSNumber numberWithDouble:0.37],
                                [NSNumber numberWithDouble:0.33],
                                [NSNumber numberWithDouble:0.32],
                                [NSNumber numberWithDouble:0.31],
                                [NSNumber numberWithDouble:0.26],
                                [NSNumber numberWithDouble:0.26],
                                [NSNumber numberWithDouble:0.25],
                                [NSNumber numberWithDouble:0.21],
                                [NSNumber numberWithDouble:0.21],
                                [NSNumber numberWithDouble:0.18],
                                [NSNumber numberWithDouble:0.17],
                                [NSNumber numberWithDouble:0.15],
                                [NSNumber numberWithDouble:0.14],
                                [NSNumber numberWithDouble:0.12],
                                [NSNumber numberWithDouble:0.12],
                                [NSNumber numberWithDouble:0.1],
                                [NSNumber numberWithDouble:0.08],
                                [NSNumber numberWithDouble:0.08],
                                [NSNumber numberWithDouble:0.07],
                                [NSNumber numberWithDouble:0.05],
                                [NSNumber numberWithDouble:0.05],
                                [NSNumber numberWithDouble:0.04],
                                [NSNumber numberWithDouble:0.03],
                                [NSNumber numberWithDouble:0.03],
                                [NSNumber numberWithDouble:0.02],
                                [NSNumber numberWithDouble:0.02],
                                [NSNumber numberWithDouble:0.01],
                                [NSNumber numberWithDouble:0.01],
                                [NSNumber numberWithDouble:0]  ];
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (int i=0; i < [animationArray count]; i++) {
        NSNumber *number = [animationArray objectAtIndex:i];
        [returnArray addObject:[NSNumber numberWithDouble:[number doubleValue]/90*angle]];
    }
    return returnArray;
}

- (NSArray *)animationArrayWithOffsetPoint:(CGPoint)offsetPoint {
    NSArray *animationArray = @[
                                [NSNumber numberWithDouble:4.700000],
                                [NSNumber numberWithDouble:4.850000],
                                [NSNumber numberWithDouble:4.700000],
                                [NSNumber numberWithDouble:4.250000],
                                [NSNumber numberWithDouble:4.350000],
                                [NSNumber numberWithDouble:3.750000],
                                [NSNumber numberWithDouble:4.549999],
                                [NSNumber numberWithDouble:3.650000],
                                [NSNumber numberWithDouble:3.750000],
                                [NSNumber numberWithDouble:3.400002],
                                [NSNumber numberWithDouble:3.500000],
                                [NSNumber numberWithDouble:2.950001],
                                [NSNumber numberWithDouble:3.399998],
                                [NSNumber numberWithDouble:3.049999],
                                [NSNumber numberWithDouble:2.600002],
                                [NSNumber numberWithDouble:3.000000],
                                [NSNumber numberWithDouble:2.649998],
                                [NSNumber numberWithDouble:2.300003],
                                [NSNumber numberWithDouble:2.549995],
                                [NSNumber numberWithDouble:2.350006],
                                [NSNumber numberWithDouble:1.949997],
                                [NSNumber numberWithDouble:2.349998],
                                [NSNumber numberWithDouble:1.900002],
                                [NSNumber numberWithDouble:1.650002],
                                [NSNumber numberWithDouble:1.900002],
                                [NSNumber numberWithDouble:1.699997],
                                [NSNumber numberWithDouble:1.400002],
                                [NSNumber numberWithDouble:1.599998],
                                [NSNumber numberWithDouble:1.400002],
                                [NSNumber numberWithDouble:1.150002],
                                [NSNumber numberWithDouble:1.349998],
                                [NSNumber numberWithDouble:1.150002],
                                [NSNumber numberWithDouble:0.949997],
                                [NSNumber numberWithDouble:1.050003],
                                [NSNumber numberWithDouble:0.899994],
                                [NSNumber numberWithDouble:0.800003],
                                [NSNumber numberWithDouble:0.849998],
                                [NSNumber numberWithDouble:0.700005],
                                [NSNumber numberWithDouble:0.549995],
                                [NSNumber numberWithDouble:0.650002],
                                [NSNumber numberWithDouble:0.550003],
                                [NSNumber numberWithDouble:0.399994],
                                [NSNumber numberWithDouble:0.500000],
                                [NSNumber numberWithDouble:0.350006],
                                [NSNumber numberWithDouble:0.299995],
                                [NSNumber numberWithDouble:0.349998],
                                [NSNumber numberWithDouble:0.250000],
                                [NSNumber numberWithDouble:0.200005],
                                [NSNumber numberWithDouble:0.199997],
                                [NSNumber numberWithDouble:0.150002],
                                [NSNumber numberWithDouble:0.099998],
                                [NSNumber numberWithDouble:0.150002],
                                [NSNumber numberWithDouble:0.050003],
                                [NSNumber numberWithDouble:0.049995],
                                [NSNumber numberWithDouble:0.050003],
                                [NSNumber numberWithDouble:0.049995],
                                [NSNumber numberWithDouble:0.020004],
                                [NSNumber numberWithDouble:0.019997],
                                [NSNumber numberWithDouble:0.010002],
                                ];
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (int i=0; i < [animationArray count]-1; i++) {
        NSNumber *number = [animationArray objectAtIndex:i];
        [returnArray addObject:[NSValue valueWithCGPoint:
                                CGPointMake(offsetPoint.x*([number floatValue]/100), offsetPoint.y*([number floatValue]/100))]];
    }
    return returnArray;
}

- (NSArray *)animationArrayWithDistance:(double)distance{
    NSArray *animationArray = @[
                                [NSNumber numberWithDouble:4.700000],
                                [NSNumber numberWithDouble:4.850000],
                                [NSNumber numberWithDouble:4.700000],
                                [NSNumber numberWithDouble:4.250000],
                                [NSNumber numberWithDouble:4.350000],
                                [NSNumber numberWithDouble:3.750000],
                                [NSNumber numberWithDouble:4.549999],
                                [NSNumber numberWithDouble:3.650000],
                                [NSNumber numberWithDouble:3.750000],
                                [NSNumber numberWithDouble:3.400002],
                                [NSNumber numberWithDouble:3.500000],
                                [NSNumber numberWithDouble:2.950001],
                                [NSNumber numberWithDouble:3.399998],
                                [NSNumber numberWithDouble:3.049999],
                                [NSNumber numberWithDouble:2.600002],
                                [NSNumber numberWithDouble:3.000000],
                                [NSNumber numberWithDouble:2.649998],
                                [NSNumber numberWithDouble:2.300003],
                                [NSNumber numberWithDouble:2.549995],
                                [NSNumber numberWithDouble:2.350006],
                                [NSNumber numberWithDouble:1.949997],
                                [NSNumber numberWithDouble:2.349998],
                                [NSNumber numberWithDouble:1.900002],
                                [NSNumber numberWithDouble:1.650002],
                                [NSNumber numberWithDouble:1.900002],
                                [NSNumber numberWithDouble:1.699997],
                                [NSNumber numberWithDouble:1.400002],
                                [NSNumber numberWithDouble:1.599998],
                                [NSNumber numberWithDouble:1.400002],
                                [NSNumber numberWithDouble:1.150002],
                                [NSNumber numberWithDouble:1.349998],
                                [NSNumber numberWithDouble:1.150002],
                                [NSNumber numberWithDouble:0.949997],
                                [NSNumber numberWithDouble:1.050003],
                                [NSNumber numberWithDouble:0.899994],
                                [NSNumber numberWithDouble:0.800003],
                                [NSNumber numberWithDouble:0.849998],
                                [NSNumber numberWithDouble:0.700005],
                                [NSNumber numberWithDouble:0.549995],
                                [NSNumber numberWithDouble:0.650002],
                                [NSNumber numberWithDouble:0.550003],
                                [NSNumber numberWithDouble:0.399994],
                                [NSNumber numberWithDouble:0.500000],
                                [NSNumber numberWithDouble:0.350006],
                                [NSNumber numberWithDouble:0.299995],
                                [NSNumber numberWithDouble:0.349998],
                                [NSNumber numberWithDouble:0.250000],
                                [NSNumber numberWithDouble:0.200005],
                                [NSNumber numberWithDouble:0.199997],
                                [NSNumber numberWithDouble:0.150002],
                                [NSNumber numberWithDouble:0.099998],
                                [NSNumber numberWithDouble:0.150002],
                                [NSNumber numberWithDouble:0.050003],
                                [NSNumber numberWithDouble:0.049995],
                                [NSNumber numberWithDouble:0.050003],
                                [NSNumber numberWithDouble:0.049995],
                                [NSNumber numberWithDouble:0.020004],
                                [NSNumber numberWithDouble:0.019997],
                                [NSNumber numberWithDouble:0.010002],
                                ];
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (int i=0; i < [animationArray count]-1; i++) {
        NSNumber *number = [animationArray objectAtIndex:i];
        [returnArray addObject:[NSNumber numberWithDouble:[number floatValue]/100*distance]];
    }
    return returnArray;
}

- (NSArray *)animationArrayDistance:(double)distance{
    NSMutableArray *returnArray = [NSMutableArray array];
    for (int i=0; i < 100; i++) {
        [returnArray addObject:[NSNumber numberWithDouble:distance/100]];
    }
    return returnArray;
}







- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

#pragma mark - layer
- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}

- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}

- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    //给Cell设置阴影效果
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


#pragma mark - base
- (UIViewController *)viewController {
    
    id nextResponder = [self nextResponder];
    while (nextResponder != nil) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)nextResponder;
            return vc;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
@end
