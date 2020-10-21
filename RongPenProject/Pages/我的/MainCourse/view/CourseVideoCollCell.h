//
//  CourseVideoCollCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "CourseVideoModel.h"
#import "GoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseVideoCollCell : UICollectionViewCell

@property(nonatomic,strong)CourseVideoModel    *model;
@property(nonatomic,strong)GoodsModel          *goodeModel;

@end

NS_ASSUME_NONNULL_END
