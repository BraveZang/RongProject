//
//  CheckpointListVC.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "DZBaseViewController.h"
#import "UnitModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckpointListVC : DZBaseViewController
@property (nonatomic, strong) UnitModel     *unitModel;

/// 闯关类型 0=闯关听写  1=中英互译
@property (nonatomic, assign) NSInteger         confirmType;
@end

NS_ASSUME_NONNULL_END
