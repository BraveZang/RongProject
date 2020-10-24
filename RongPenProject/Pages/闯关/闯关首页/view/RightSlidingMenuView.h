//
//  RightSlidingMenuView.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/21.
//

#import <UIKit/UIKit.h>
#import "MainBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RightSlidingMenuView : UIView

@property (nonatomic, copy) void(^seletedBookblock)(MainBookModel*bookModel);

@property (nonatomic, strong) NSArray       *bookList;
@end

NS_ASSUME_NONNULL_END
