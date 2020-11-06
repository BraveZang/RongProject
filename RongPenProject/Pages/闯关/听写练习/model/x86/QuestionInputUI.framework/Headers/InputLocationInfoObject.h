//
//  InputLocationInfoObject.h
//  填空题
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 cheniue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuestionInputUI/LocationTextAttachment.h>

@interface QuestionInputFunctionField : UITextField

@property(nonatomic,strong)UIImageView *bottomLine;

@end

@interface InputLocationInfoObject : NSTextAttachment

@property(nonatomic,assign)CGSize inputSize;
@property(nonatomic,assign)NSInteger insertIndex;
@property(nonatomic,copy)UIFont *font;
@property(nonatomic,strong)QuestionInputFunctionField *inputContentField;
@property(nonatomic,strong)NSMutableAttributedString *locationAttributeText;
@property(nonatomic,strong)LocationTextAttachment *textAttachment;

-(instancetype)initWithInputSize:(CGSize)size locationIndex:(NSInteger)startIndex;
-(void)showInputView;
-(void)hideInputView;

@end
