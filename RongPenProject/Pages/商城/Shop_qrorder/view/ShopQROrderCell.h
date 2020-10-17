//
//  ShopQROrderCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopQROrderCell : UITableViewCell


@property (nonatomic, strong) UILabel         *nameLab;
@property (nonatomic, strong) UILabel         *contentLab;
@property (nonatomic, strong) UILabel         *introLab;
@property (nonatomic, strong) UILabel         *moneyLab;
@property (nonatomic, strong) UIImageView     *img;

@property (nonatomic, strong) UIView          *bgView;

@end

NS_ASSUME_NONNULL_END
