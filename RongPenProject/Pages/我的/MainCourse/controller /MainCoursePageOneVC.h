//
//  MainCoursePageOneVC.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//

#import "DZBaseViewController.h"
#import "CourseVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainCoursePageOneVC : DZBaseViewController
@property (copy, nonatomic) void(^tiemClickBlock)(CourseVideoModel*model);

@end

NS_ASSUME_NONNULL_END
