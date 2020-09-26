//
//  RightSlidingMenuView.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightSlidingMenuView : UIView

@property (nonatomic, copy) void(^block)(NSString*str);


@end

NS_ASSUME_NONNULL_END
