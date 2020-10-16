//
//  HaveBuyView.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import <UIKit/UIKit.h>
#import "ShopInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HaveBuyView : UIView

@property(nonatomic,strong) ShopInfoModel                 *model;
@property(nonatomic,strong) NSArray                       *glteachingAry;
@property (nonatomic, copy) void(^click)(NSArray *goodAry);

@end

NS_ASSUME_NONNULL_END
