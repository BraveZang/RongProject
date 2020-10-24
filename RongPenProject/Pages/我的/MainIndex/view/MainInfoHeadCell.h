//
//  MainInfoHeadCell.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainInfoHeadCell : UITableViewCell
@property (nonatomic, strong) InfoModel       *model;
@property (nonatomic, strong) UIImageView       *headView;

@end

NS_ASSUME_NONNULL_END
