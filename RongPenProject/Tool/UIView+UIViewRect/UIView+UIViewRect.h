//
//  UIView+UIViewRect.h
//  SanMuZhuangXiu
//
//  Created by apple on 2019/7/5.
//  Copyright © 2019 Darius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewRect)

///**
// view的y坐标
// */
//@property CGFloat top;
//
///**
// view的x坐标
// */
//@property CGFloat left;
///**
// y+height
// */
//@property CGFloat bottom;
//
///**
// x+width
// */
//@property CGFloat right;

/**
 * @brief   设置X坐标
 * @param   x 要设置的x
 */
- (void)setFrameX:(CGFloat)x;

/**
* @brief   设置Y坐标
* @param   y 要设置的y
*/
- (void)setFrameY:(CGFloat)y;
//
/**
 * @brief   设置X和Y坐标
 * @param   x 要设置的x
 * @param   y 要设置的y
 */
- (void)setFrameXAndY:(CGFloat)x y:(CGFloat)y;

/**
 * @brief   设置宽
 * @param   width 要设置的宽
 */
- (void)setFrameWidth:(CGFloat)width;

/**
 * @brief   设置高
 * @param   height 要设置的高
 */
- (void)setFrameHeight:(CGFloat)height;

/**
 * @brief   设置宽和高
 * @param   width 要设置的宽
 * @param   height 要设置的高
 */
- (void)setFrameWidthAndHeight:(CGFloat)width height:(CGFloat)height;


@end
