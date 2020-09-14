//
//  MKSearchBar.m
//  SanMuZhuangXiu
//
//  Created by apple on 2019/7/5.
//  Copyright © 2019 Darius. All rights reserved.
//


#import "MKSearchBar.h"
#import "UIImage+CZHExtension.h"

@interface MKSearchBar () <UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

// icon宽度
static CGFloat const searchIconW = 20.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;
// 占位文字的字体大小
static CGFloat const placeHolderFont = 12.0;

@implementation MKSearchBar

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置背景图片
   UIImage *backImage = [UIImage czh_imageWithColor:[UIColor clearColor]];
    [self setBackgroundImage:backImage];
    for (UIView *view in [self.subviews lastObject].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            self.field = (UITextField *)view;
            // 重设field的frame
            [ self.field setBackgroundColor:[MTool colorWithHexString:@"f4f4f4"]];
//            field.textColor = [MTool colorWithHexString:@"bbbbbb"];
//             self.field.placeholder = @"请输入搜索的内容";
             self.field.borderStyle = UITextBorderStyleNone;
             self.field.textAlignment=NSTextAlignmentCenter;
             self.field.layer.cornerRadius = 5.0f;
             self.field.layer.masksToBounds = YES;
            self.field.delegate=self;
            // 设置占位文字字体颜色
            [ self.field setValue:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
            [ self.field setValue:[UIFont systemFontOfSize:placeHolderFont] forKeyPath:@"_placeholderLabel.font"];
            
//            NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : self.placeholderColor}];
//            self.field.attributedPlaceholder = placeholderString;
           
            if (@available(iOS 11.0, *)) {
                // 先默认居中placeholder
                [self setPositionAdjustment:UIOffsetMake(( self.field.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
            }
        }
    }
}

// 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 继续传递代理方法
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
// 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}

// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFont]} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
