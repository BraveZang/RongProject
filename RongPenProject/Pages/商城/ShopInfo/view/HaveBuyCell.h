//
//  HaveBuyCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HaveBuyCell : UITableViewCell

@property (nonatomic, strong) UILabel         *nameLab;
@property (nonatomic, strong) UILabel         *moneyLab;
@property (nonatomic, strong) UIView          *bgView;
@property (nonatomic, assign) BOOL            select;


@end

NS_ASSUME_NONNULL_END
