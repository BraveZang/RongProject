//
//  ReLayoutButton.h
//  test
//
//  Created by LWX on 2017/11/6.
//  Copyright © 2017年 LWX. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 IB_DESIGNABLE 动态刷新类
 IBInspectable 可视化属性
 */

typedef NS_ENUM(NSInteger,RelayoutType) {
    /// 系统默认样式
    RelayoutTypeNone = 0,
    /// 上图下文
    RelayoutTypeUpDown = 1,
    /// 左文右图
    RelayoutTypeRightLeft = 2,
};

IB_DESIGNABLE
@interface ReLayoutButton : UIButton


/** 布局样式*/
@property (assign,nonatomic) IBInspectable NSInteger  layoutType;
@property (assign,nonatomic) IBInspectable CGFloat  margin;


@end
