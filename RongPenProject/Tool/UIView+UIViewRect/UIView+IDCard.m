//
//  UIView+IDCard.m
//  SanMuZhuangXiu
//
//  Created by 王巧云 on 2019/3/8.
//  Copyright © 2019 Darius. All rights reserved.
//

#import "UIView+IDCard.h"

@implementation UIView (IDCard)
/**
 *  输出所有子控件
 */
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName {
    // 递归出口
    if ([view isKindOfClass:NSClassFromString(clazzName)]) {
        return view;
    }
    // 遍历所有子视图
    for (UIView *subView in view.subviews) {
        UIView *foundView = [self ff_foundViewInView:subView clazzName:clazzName];
        if (foundView) {
            return foundView;
        }
    }
    return nil;
}
@end
