//
//  UIView+IDCard.h
//  SanMuZhuangXiu
//
//  Created by 王巧云 on 2019/3/8.
//  Copyright © 2019 Darius. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (IDCard)
/// 查找子视图且不会保存
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)ff_foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;
@end

NS_ASSUME_NONNULL_END
