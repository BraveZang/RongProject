//
//  ReadInfoItemView.h
//  RongPenProject
//
//  Created by czg on 2020/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReadInfoItemView : UIView

@property (nonatomic, copy) void(^helpBtnblock)(void);
@property (nonatomic, copy) void(^playBtnblock)(void);
@property (nonatomic, copy) void(^readBtnblock)(void);

@property (nonatomic, copy) void(^connectBtnblock)(void);


@end

NS_ASSUME_NONNULL_END
