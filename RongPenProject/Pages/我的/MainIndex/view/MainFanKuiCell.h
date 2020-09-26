//
//  MainFanKuiCell.h
//  RongPenProject
//
//  Created by zanghui  on 2020/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainFanKuiCell : UITableViewCell<UITextViewDelegate>

@property (strong,nonatomic) UILabel               *tagLab;
@property (strong,nonatomic) UILabel               *titleLab;
@property (strong,nonatomic) UIView                *sexView;
@property (strong,nonatomic) UIButton              *womanBtn;
@property (strong,nonatomic) UIButton              *manBtn;
@property (strong,nonatomic) UITextView            *describeView;
@end

NS_ASSUME_NONNULL_END
