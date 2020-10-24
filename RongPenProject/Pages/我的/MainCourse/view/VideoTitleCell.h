//
//  VideoTitleCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import "MainCourseDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoTitleCell : UITableViewCell
@property(nonatomic,strong)UILabel                      *titleLab;
@property(nonatomic,strong)UILabel                      *npriceLab;
@property(nonatomic,strong)UILabel                      *contentLab1;
@property(nonatomic,strong)UILabel                      *contentLab2;
@property(nonatomic,strong)MainCourseDetailModel        *model;


@end

NS_ASSUME_NONNULL_END
