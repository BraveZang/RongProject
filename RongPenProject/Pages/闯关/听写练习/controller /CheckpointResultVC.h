//
//  CheckpointResultVC.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import "DZBaseViewController.h"
#import "HYBStarEvaluationView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckpointResultVC : DZBaseViewController

@property (nonatomic,strong) UIImageView           *titleImg;
@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UIButton              *nextBtn;
@property (strong,nonatomic) UIButton              *allBtn;
@property (strong,nonatomic) UIButton              *timeBtn;
@property (strong,nonatomic) HYBStarEvaluationView *starView;
@end

NS_ASSUME_NONNULL_END
