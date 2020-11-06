//
//  LocationTextAttachment.h
//  填空题
//
//  Created by apple on 2017/9/7.
//  Copyright © 2017年 cheniue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTextAttachment : NSTextAttachment

@property(nonatomic,copy)void (^attachmentContentBlock)(CGRect inputRect);

-(instancetype)initWithInputSize:(CGSize)size;

@end
