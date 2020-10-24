//
//  ZRPickerView.h
//  ZRPickerView
//
//  Created by mac on 21/06/2019.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
NS_ASSUME_NONNULL_BEGIN



typedef void(^ZRPickerViewDidSelectRowBlock)(AreaModel* provinceModel, AreaModel *cityModel ,AreaModel*areaModel);

@interface ZRPickerView : UIView





- (instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray *)dataArray;

@property (nonatomic, copy)ZRPickerViewDidSelectRowBlock didSelectRowBlock;

@property (nonatomic, assign) NSInteger         pickerRow;

@end

NS_ASSUME_NONNULL_END
