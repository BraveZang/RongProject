//
//  DictationListCell.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DictationListCell : UITableViewCell

@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UILabel               *contentLab;
@property (strong,nonatomic) UIButton              *playBtn;
@property (nonatomic,strong) UIProgressView        *progressView;

@end

NS_ASSUME_NONNULL_END
