//
//  MessageDetailCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/24.
//

#import <UIKit/UIKit.h>
#import "MessageDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailCell : UITableViewCell

@property(nonatomic,strong)UILabel        *nameLab;
@property(nonatomic,strong)UILabel                   *contentLab;
@property(nonatomic,strong)UILabel                   *timeLab;
@property(nonatomic,strong)MessageDetailModel        *model;

@end

NS_ASSUME_NONNULL_END
