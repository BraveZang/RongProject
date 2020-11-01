//
//  PayCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PayCell : UITableViewCell

@property(nonatomic,strong) UILabel             *nameLab;
@property(nonatomic,strong) UILabel             *payTitleLab;
@property(nonatomic,strong) UIImageView         *iconImg;
@property(nonatomic,strong) UILabel             *rightLab;
@property(nonatomic,strong) UIView              *lineView;
@property(nonatomic,strong) UIView              *bgView;
@end

NS_ASSUME_NONNULL_END
