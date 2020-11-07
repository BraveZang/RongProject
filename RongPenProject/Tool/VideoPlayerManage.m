//
//  VideoPlayerManage.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import "VideoPlayerManage.h"


@implementation VideoPlayerManage

+ (instancetype)instance
{
    static VideoPlayerManage *playerManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerManage = [[VideoPlayerManage alloc] init];
    });
    return playerManage;
}

- (instancetype)init
{
    if (self = [super init]) {
        _playerListArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)playItemWithItemUrl:(NSString *)itemUrl{
    
    //暂停列表播放 改变按钮状态  待优化
//    [self.queuePlayer pause];

    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:itemUrl]];
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:videoItem];
    [self.avPlayer play];
}



- (void)setPlayerDataSourceWithURLArray:(NSArray *)urlArray
{
    [self.playerListArray removeAllObjects];
    for (id item in urlArray) {
        AVPlayerItem *videoItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:item]];
        [self.playerListArray addObject:videoItem];
    }
    self.queuePlayer = [AVQueuePlayer queuePlayerWithItems:[NSArray arrayWithArray:self.playerListArray]];
}

- (void)play
{
    [self.queuePlayer play];
}

- (void)pause
{
    [self.queuePlayer pause];
}

- (void)playNext
{
    [self.queuePlayer advanceToNextItem];
}

- (void)playWithIndex:(NSInteger)index
{
    [self.queuePlayer removeAllItems];
    for (int i = index; i <self.playerListArray.count; i ++) {
        AVPlayerItem* obj = [self.playerListArray objectAtIndex:i];
        if ([self.queuePlayer canInsertItem:obj afterItem:nil]) {
            [obj seekToTime:kCMTimeZero];
            [self.queuePlayer insertItem:obj afterItem:nil];
        }
    }
}

@end
