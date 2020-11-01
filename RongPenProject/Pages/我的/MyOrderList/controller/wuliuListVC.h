//
//  wuliuListVC.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/2.
//

#import "DZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface wuliuListVC : DZBaseViewController
@property (nonatomic, strong)  NSArray                       *ary;
@property (nonatomic, strong) void(^ItemBlock)(NSDictionary *dic);

@end

NS_ASSUME_NONNULL_END
