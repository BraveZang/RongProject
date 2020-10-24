//
//  ZRInfoPickerView.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ZRPickerViewDidSelectRowBlock)(NSString* selectDataStr);

@interface ZRInfoPickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray;

@property (nonatomic, copy)ZRPickerViewDidSelectRowBlock didSelectRowBlock;

- (void)updateDataArray:(NSArray *)dataArray;

- (void)showZRInfoPickerView;
- (void)hiddenZRInfoPickerView;

@end

NS_ASSUME_NONNULL_END
