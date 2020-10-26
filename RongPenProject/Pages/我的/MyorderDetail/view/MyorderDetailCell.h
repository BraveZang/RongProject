//
//  MyorderDetailCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import"MyorderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyorderDetailCell : UITableViewCell

@property(nonatomic,strong) UILabel             *timeLab;
@property(nonatomic,strong) UILabel             *statusLab;
@property(nonatomic,strong) UIImageView         *heardImg;
@property(nonatomic,strong) UILabel             *nameLab;
@property(nonatomic,strong) UILabel             *gradeLab;
@property(nonatomic,strong) UILabel             *subjectsLab;
@property(nonatomic,strong) UILabel             *moneyLab;
@property(nonatomic,strong) UILabel             *yunfeiLab;
@property(nonatomic,strong) UILabel             *markLab;
@property(nonatomic,strong) UILabel             *totaleMoneyLab;
@property(nonatomic,strong) MyorderDetailModel  *model;


@end

NS_ASSUME_NONNULL_END
