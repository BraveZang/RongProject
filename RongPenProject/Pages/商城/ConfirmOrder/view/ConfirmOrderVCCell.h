//
//  ConfirmOrderVCCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/13.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderVCCell : UITableViewCell

@property(nonatomic,strong) UIImageView         *heardImg;
@property(nonatomic,strong) UILabel             *nameLab;
@property(nonatomic,strong) UILabel             *gradeLab;
@property(nonatomic,strong) UILabel             *subjectsLab;
@property(nonatomic,strong) UILabel             *moneyLab;
@property(nonatomic,strong) UIView              *bottomView;
@property(strong,nonatomic) PPNumberButton      *numberBtn;



@end

NS_ASSUME_NONNULL_END
