//
//  InputQuestionContentView.h
//  填空题
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 cheniue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuestionInputUI/InputLocationInfoObject.h>

@interface InputQuestionContentView : UILabel

@property(nonatomic,strong)NSMutableAttributedString *questionText;
@property(nonatomic,strong)NSMutableArray *saveInputLocationsArray;

-(instancetype)initWithStartPoint:(CGPoint)startPoint contentWidth:(CGFloat)contentWidth text:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor lineGap:(CGFloat)lineGap wordGap:(CGFloat)wordGap inputLocations:(NSMutableArray<__kindof InputLocationInfoObject*>*)inputLocations;

@end
