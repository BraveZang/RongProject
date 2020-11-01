//
//  danhaoCell.h
//  RongPenProject
//
//  Created by 路面机械网  on 2020/11/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface danhaoCell : UITableViewCell<UITextFieldDelegate>

@property (copy, nonatomic) void(^textfieldStrBlock)(NSString*str);

@end

NS_ASSUME_NONNULL_END
