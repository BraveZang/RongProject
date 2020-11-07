//
//  SHBPlayer.h
//  SHBNetRequestDemo
//
//  Created by shenhongbang on 16/6/6.
//  Copyright © 2016年 shenhongbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol SHBQueuePlayerDelegate <NSObject>

@optional
- (void)queuePlayerEndPlayed:(AVPlayerItem *)item;

@end

@interface SHBQueuePlayer : NSObject

/**
 *  AVQueuePlayer 继承于 AVPlayer，所以可以播放视频、音频列表
 */
@property (nonatomic, strong, readonly) AVQueuePlayer   *queuePlayer;
@property (nonatomic, assign) id<SHBQueuePlayerDelegate> delegate;

+ (SHBQueuePlayer *)defaultManager;

/**
 *  播放进度回调
 */
@property (nonatomic, copy) void(^progress)(NSTimeInterval currentTime, NSTimeInterval duration);

/**
 *  是否正在播放
 */
@property (nonatomic, assign, readonly) BOOL    isPlaying;


/**
 *  是否正在播放
 */
@property (nonatomic, assign) NSInteger    itemIndex;

/**
 *  设置播放列表
 *
 *  @param urls  列表url
 *  @param index 要播放的元素位置
 */
- (void)setUrls:(NSArray <NSURL *>*)urls index:(NSInteger)index;

/**
 *  上一首
 */
- (void)lastItem;

/**
 *  下一首
 */
- (void)nextItem;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;


@end
