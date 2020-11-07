//
//  VideoPlayerManage.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerManage : NSObject

@property (strong, nonatomic) AVQueuePlayer *queuePlayer;
@property (strong, nonatomic) NSMutableArray *playerListArray;


/**
 *  AVPlayer，可以单个播放视频、音频
 */
@property (nonatomic, strong) AVPlayer   *avPlayer;

/**
 *  单例
 *
 *  @return id
 */
+ (instancetype)instance;

/**
 *  初始化Player的数据源
 *
 *  @param urlArray url数组,存NSString类型
 */
- (void)setPlayerDataSourceWithURLArray:(NSArray *)urlArray;


- (void)playItemWithItemUrl:(NSString *)itemUrl;





/**
 *  播放下一集
 */
- (void)playNext;

/**
 *  播放某一集
 *
 *  @param index 某集的序号
 */
- (void)playWithIndex:(NSInteger)index;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;




@end
