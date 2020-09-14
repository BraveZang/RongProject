//
//  AppDelegate.m
//  jiyouhui2020
//
//  Created by zanghui  on 2020/7/30.
//  Copyright © 2020 zanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DZBaseViewController : UIViewController
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIView*lineview;
@property(nonatomic,strong)UIButton*leftImgBtn;
@property(nonatomic,strong)UIButton*rightImgBtn;
@property(nonatomic,strong)UIView*topview;
@property(nonatomic,strong)UILabel*toptitle;

//- (void)backItemClicked;
// 设置UINvigationBar 左右键方法
- (void)setNavigationButtonItrmWithiamge:(NSString *)imagename withRightOrleft:(NSString*)f withtargrt:(id)t withAction:(SEL)s;

@end

NS_ASSUME_NONNULL_END
