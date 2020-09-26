//
//  MainMessageCell.h
//  SanMuZhuangXiu
//
//  Created by zanghui  on 2020/5/28.
//  Copyright © 2020 Darius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainMessageCell : UITableViewCell


@property(nonatomic,strong)UILabel        *contentLab;
@property(nonatomic,strong)UIImageView    *heardImg;
@property(nonatomic,strong)UILabel        *nameLab;
@property(nonatomic,strong)UILabel        *timeLab;
@property(nonatomic,strong)MessageModel   *model;


@end

NS_ASSUME_NONNULL_END
