//
//  AddressManagerListCell.h
//  SanMuZhuangXiu
//
//  Created by 犇犇网络 on 2018/12/28.
//  Copyright © 2018 Darius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressManagerListCell : UITableViewCell

@property (strong, nonatomic)  UILabel  *nameLabel;
@property (strong, nonatomic)  UILabel  *markLabel;
@property (strong, nonatomic)  UILabel  *defaulLabel;
@property (strong, nonatomic)  UILabel  *addressLabel;
@property (strong, nonatomic)  UIButton *editBtn;
@property (strong, nonatomic)  AddressModel*model;
//block
@property (copy, nonatomic) void(^deleteBlock)(void);
@property (copy, nonatomic) void(^morenBlock)(void);
@property (copy, nonatomic) void(^editBlock)(AddressModel*model);

@end

NS_ASSUME_NONNULL_END
