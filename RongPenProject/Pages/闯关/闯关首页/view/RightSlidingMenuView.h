//
//  RightSlidingMenuView.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/21.
//

#import <UIKit/UIKit.h>
#import "MainBookModel.h"
#import "UnitModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RightSlidingMenuView : UIView

@property (nonatomic, copy) void(^seletedBookblock)(MainBookModel*bookModel);

@property (nonatomic, copy) void(^seletedUnitblock)(UnitModel*unitModel);

/// 1=教辅列表    2=单元列表
@property (nonatomic, assign) NSInteger     type;

/// 教辅列表
@property (nonatomic, strong) NSArray       *bookList;

/// 单元列表
@property (nonatomic, strong) NSArray       *unitList;


@end

NS_ASSUME_NONNULL_END
