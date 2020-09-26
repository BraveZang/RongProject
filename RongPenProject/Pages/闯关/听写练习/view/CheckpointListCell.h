//
//  CheckpointListCell.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import <UIKit/UIKit.h>
#import "HYBStarEvaluationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckpointListCell : UITableViewCell

@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UIButton              *playBtn;
@property (strong,nonatomic) UIButton              *timeBtn;
@property (strong, nonatomic)HYBStarEvaluationView *starView;


@end

NS_ASSUME_NONNULL_END
