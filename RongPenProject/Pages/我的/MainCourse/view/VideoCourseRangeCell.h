//
//  VideoCourseRangeCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/10/25.
//

#import <UIKit/UIKit.h>
#import "CourSerAngeModel.h"
#import "RecordeDetailModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface VideoCourseRangeCell : UITableViewCell

@property(nonatomic,strong)UILabel                      *titleLab;
@property(nonatomic,strong)UILabel                      *nameLab;
@property(nonatomic,strong)UILabel                      *timeLab1;
@property(nonatomic,strong)UIImageView                  *playImg;
@property(nonatomic,strong)CourSerAngeModel             *model;
@property(nonatomic,strong)RecordeDetailModel           *recordeModel;

@end

NS_ASSUME_NONNULL_END
