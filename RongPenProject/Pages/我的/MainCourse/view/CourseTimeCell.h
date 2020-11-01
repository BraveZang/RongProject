//
//  CourseTimeCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseTimeCell : UITableViewCell

@property(nonatomic,strong)UILabel                      *nameLab;
@property(nonatomic,strong)UIButton                     *selectBtn;
@property (nonatomic, strong) void(^Block)(void);

@end

NS_ASSUME_NONNULL_END
