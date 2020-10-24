//
//  MainInfoCell.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainInfoCell : UITableViewCell
@property (nonatomic, strong) InfoModel       *model;
@property (nonatomic, strong) UILabel         *contentLabel;
@end

NS_ASSUME_NONNULL_END
