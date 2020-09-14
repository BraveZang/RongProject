//
//  UIView.h
//  UXKit
//
//  Created by OranWu on 13-5-8.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Additions)


/**  起点x坐标  */
@property (nonatomic, assign) CGFloat x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat centerY;
/**  宽度  */
@property (nonatomic, assign) CGFloat width;
/**  高度  */
@property (nonatomic, assign) CGFloat height;
/**  顶部  */
@property (nonatomic, assign) CGFloat top;
/**  底部  */
@property (nonatomic, assign) CGFloat bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat left;
/**  右边  */
@property (nonatomic, assign) CGFloat right;
/**  size  */
@property (nonatomic, assign) CGSize size;
/**  origin */
@property (nonatomic, assign) CGPoint origin;


@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;


/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;
- (id)initWithIOS7Frame:(CGRect)frame;

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;

- (void)rotateWithAngle:(CGFloat)angel animateDuration:(CGFloat)duration;

- (void)setScale:(float)scale;
- (void)setOrigin:(CGPoint)origin Scale:(float)scale;
- (void)setCenter:(CGPoint)center Scale:(float)scale;
- (void)setRightTop:(CGPoint)origin Scale:(float)scale;


- (void)addImage:(UIImage*)image atPoint:(CGPoint)point;
- (void)removeAllSubviews;

- (void)drawCircleAtCenterPoint:(CGPoint)center radius:(float)radius fill:(BOOL)isFill;

- (NSArray *)animationArrayWithAngle:(double)angle;
- (NSArray *)animationArrayWithOffsetPoint:(CGPoint)offsetPoint;
- (NSArray *)animationArrayWithDistance:(double)distance;

- (NSArray *)animationArrayDistance:(double)distance;
@end
