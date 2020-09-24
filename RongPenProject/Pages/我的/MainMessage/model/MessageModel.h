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

@property(nonatomic,strong)NSString     *conversationType;
@property(nonatomic,strong)NSString     *id;
@property(nonatomic,strong)NSDictionary *lastMessage;
@property(nonatomic,strong)NSString     *receivedTime;
@property(nonatomic,strong)NSString     *sentTime;
@property(nonatomic,strong)NSString     *targetId;
@property(nonatomic,strong)NSString     *unreadCount;






@end

NS_ASSUME_NONNULL_END
