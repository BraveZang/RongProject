//
//  InfoModel.h
//  AloneWalker
//
//  Created by mac on 18/06/2019.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoModel : UIView

- (instancetype)initWithTitle:(NSString *)title  Content:(NSString *)content  andalert:(NSString *)alert;


@property (nonatomic, copy) NSString       *title;
@property (nonatomic, strong) NSString     *content;
@property (nonatomic, strong) NSString     *alert;

@end

NS_ASSUME_NONNULL_END
