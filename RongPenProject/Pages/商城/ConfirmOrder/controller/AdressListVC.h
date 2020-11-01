//
//  AdressListVC.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/31.
//

#import "DZBaseViewController.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdressListVC : DZBaseViewController

@property (nonatomic, copy) void(^Block)(AddressModel*model);
@end

NS_ASSUME_NONNULL_END
