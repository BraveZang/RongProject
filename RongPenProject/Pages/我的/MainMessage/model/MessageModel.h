//
//  MessageModel.h
//  JiYouHui
//
//  Created by zanghui  on 2020/7/3.
//  Copyright © 2020 Darius. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property(nonatomic,strong)NSString     *title;
@property(nonatomic,strong)NSString     *content;
@property(nonatomic,strong)NSString     *unread;

@end

NS_ASSUME_NONNULL_END
