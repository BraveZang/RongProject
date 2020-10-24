//
//  CheckpointListCell.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import <UIKit/UIKit.h>
#import "HYBStarEvaluationView.h"
#import "gkModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckpointListCell : UITableViewCell

@property (strong,nonatomic) gkModel               *model;

@property (strong, nonatomic)HYBStarEvaluationView *starView;


@end

NS_ASSUME_NONNULL_END
