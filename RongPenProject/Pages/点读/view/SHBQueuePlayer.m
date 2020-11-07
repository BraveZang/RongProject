//
//  SHBPlayer.m
//  SHBNetRequestDemo
//
//  Created by shenhongbang on 16/6/6.
//  Copyright © 2016年 shenhongbang. All rights reserved.
//

#import "SHBQueuePlayer.h"

@interface SHBQueuePlayer ()

@property (nonatomic, strong) AVQueuePlayer     *qPlayer;

@end

@implementation SHBQueuePlayer {
    NSMutableArray      *_nextUrls;
    NSMutableArray      *_playedUrls;
}

+ (SHBQueuePlayer *)defaultManager {
    static SHBQueuePlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[SHBQueuePlayer alloc] init];
    });
    return player;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemIndex = 0;
        _playedUrls = [NSMutableArray arrayWithCapacity:0];
        _nextUrls = [NSMutableArray arrayWithCapacity:0];
        _qPlayer = [AVQueuePlayer queuePlayerWithItems:@[]];
        __weak typeof(self) SHB = self;
        [_qPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            [SHB resetProgress:time];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidEndPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:_qPlayer.currentItem];
        
    }
    return self;
}

- (void)resetProgress:(CMTime)time {
    
    AVPlayerItem *item = _qPlayer.currentItem;
    
    NSTimeInterval current = CMTimeGetSeconds(item.currentTime);
    NSTimeInterval duation = CMTimeGetSeconds(item.duration);
    if (_progress) {
        _progress(current, duation);
    }    
}

- (void)resetUrls:(NSArray<NSURL *> *)urls {
    [_qPlayer removeAllItems];
    [_playedUrls removeAllObjects];
    [_nextUrls removeAllObjects];
    [_nextUrls addObjectsFromArray:urls];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:urls[0]];
    if ([_qPlayer canInsertItem:item afterItem:nil]) {
        [_qPlayer insertItem:item afterItem:nil];
    }
}

- (void)addUrls:(NSArray<NSURL *> *)urls {
    
    [_nextUrls addObjectsFromArray:urls];
    
    NSArray *playItems = _qPlayer.items;
    if (playItems.count == 0) {
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:urls[0]];
        if ([_qPlayer canInsertItem:item afterItem:nil]) {
            [_qPlayer insertItem:item afterItem:nil];
        }
    }
}

- (void)setUrls:(NSArray<NSURL *> *)urls index:(NSInteger)index {
    [_playedUrls removeAllObjects];
    [_nextUrls removeAllObjects];
    
    self.itemIndex = index;
    
    if (urls.count == 0 || urls == nil) {
        [_qPlayer removeAllItems];
        return;
    }
    
    if (index > urls.count) {   //加层保险
        index = urls.count;
    }
    
    [_playedUrls addObjectsFromArray:[urls subarrayWithRange:NSMakeRange(index, index+1)]];
    [_nextUrls addObjectsFromArray:[urls subarrayWithRange:NSMakeRange(index+1, urls.count - index-1)]];
    [_qPlayer removeAllItems];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:_nextUrls[0]];
    if ([_qPlayer canInsertItem:item afterItem:nil]) {
        [_qPlayer insertItem:item afterItem:nil];
    }
}

- (void)lastItem {
    
    if (_playedUrls.count > 0) {
        
        NSURL *url = _playedUrls[0];
        [_nextUrls insertObject:url atIndex:0];
        [_playedUrls removeObjectAtIndex:0];
        
        [_qPlayer advanceToNextItem];
        [_qPlayer removeAllItems];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        if ([_qPlayer canInsertItem:item afterItem:nil]) {
            [_qPlayer insertItem:item afterItem:nil];
        }
        [_qPlayer play];
        _isPlaying = true;
    }
}


- (void)nextItem {
    
    if (_nextUrls.count > 1) {
        [self.qPlayer advanceToNextItem];
        [_playedUrls insertObject:_nextUrls[0] atIndex:0];
        [_nextUrls removeObjectAtIndex:0];
        
        NSArray *items = _qPlayer.items;
        
        if (items.count < _nextUrls.count) {
            NSURL *url = _nextUrls[items.count];
            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
            if ([_qPlayer canInsertItem:item afterItem:nil]) {
                [_qPlayer insertItem:item afterItem:nil];
            }
        }
        
        _isPlaying = true;
        [_qPlayer play];
    }
}



- (void)play {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:true error:nil];
    _isPlaying = true;
    [self.qPlayer play];
}

- (void)pause {
    _isPlaying = false;
    [self.qPlayer pause];

}

- (void)playerItemDidEndPlay:(NSNotification *)tifi {
    _isPlaying = false;
    if ([_delegate respondsToSelector:@selector(queuePlayerEndPlayed:)]) {
        
        AVPlayerItem *item = tifi.object;
        
        [_delegate queuePlayerEndPlayed:item];
    }
    self.itemIndex ++;
    [self nextItem];
}

- (AVQueuePlayer *)queuePlayer {
    return _qPlayer;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
