//
//  DDAVPlayer.m
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "DDAVPlayer.h"

@interface DDAVPlayer ()

@end

@implementation DDAVPlayer
+(instancetype)shareInstance {
    static DDAVPlayer *infoManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        infoManagerInstance = [[self alloc] init];
        infoManagerInstance.volume = 1.0;
    });
    return infoManagerInstance;
}

- (void)playWithUrlStr:(NSString *)urlStr{
    // 移除监听
//    [self p_currentItemRemoveObserver];
    // 创建要播放的资源
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlStr]];
    // 播放当前资源
    [self replaceCurrentItemWithPlayerItem:playerItem];
    // 添加观察者
//    [self p_currentItemAddObserver];
    
    
    [self play];
}



@end
