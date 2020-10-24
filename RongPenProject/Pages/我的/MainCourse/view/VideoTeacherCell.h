//
//  VideoTeacherCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import "TeacherInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoTeacherCell : UITableViewCell

@property(nonatomic,strong)UIImageView             *heardImg;
@property(nonatomic,strong)UILabel                 *nameLab;
@property(nonatomic,strong)UILabel                 *contentLab;
@property(nonatomic,strong)TeacherInfoModel        *model;


@end

NS_ASSUME_NONNULL_END
