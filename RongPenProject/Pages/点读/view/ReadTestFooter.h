//
//  ReadTestFooter.h
//  RongPenProject
//
//  Created by mac on 1.11.20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReadTestFooter : UIView

@property (nonatomic, copy) void(^penWriteblock)(void);
@property (nonatomic, copy) void(^phoneWriteblock)(void);


@end

NS_ASSUME_NONNULL_END
