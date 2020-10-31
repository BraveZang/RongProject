//
//  MainCoursePageThreeVC.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//

#import "DZBaseViewController.h"
#import "CourseVideoModel.h"
#import "GoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainCoursePageThreeVC : DZBaseViewController
@property (copy, nonatomic) void(^tiemClickBlock)(GoodsModel*model);
@end

NS_ASSUME_NONNULL_END
