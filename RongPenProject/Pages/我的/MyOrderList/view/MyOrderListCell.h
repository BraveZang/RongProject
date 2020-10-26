//
//  MyOrderListCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import "MyOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderListCell : UITableViewCell

@property(nonatomic,strong) UILabel             *timeLab;
@property(nonatomic,strong) UILabel             *statusLab;
@property(nonatomic,strong) UIImageView         *heardImg;
@property(nonatomic,strong) UILabel             *nameLab;
@property(nonatomic,strong) UILabel             *gradeLab;
@property(nonatomic,strong) UILabel             *subjectsLab;
@property(nonatomic,strong) UILabel             *moneyLab;
@property(nonatomic,strong) UILabel             *markLab;
@property(nonatomic,strong) UIView              *bottomView;
@property(nonatomic,strong) NSDictionary        *dic;
@property(nonatomic,strong) UIButton            *bottomBtn1;
@property(nonatomic,strong) UIButton            *bottomBtn2;
@property(nonatomic,strong) UIButton            *bottomBtn3;
@property(nonatomic,strong) UIButton            *bottomBtn4;
@property(nonatomic,strong) UIButton            *bottomBtn5;
@property(nonatomic,strong) UIButton            *bottomBtn6;



@property (nonatomic, strong) void(^Block)(NSString*str);
@property(nonatomic,strong) MyOrderListModel    *model;


@end

NS_ASSUME_NONNULL_END
