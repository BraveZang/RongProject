//
//  ShopAdressCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShopAdressCell : UITableViewCell
@property(nonatomic,strong) AddressModel        *adressmodel;
@property(nonatomic,strong) UIImageView         *heardImg;
@property(nonatomic,strong) UILabel             *namelab;
@property(nonatomic,strong) UILabel             *adresslab;
@property(nonatomic,strong) UILabel             *tishilab;
@end

NS_ASSUME_NONNULL_END
