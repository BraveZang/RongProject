//
//  DDAVPlayer.h
//  RongPenProject
//
//  Created by czg on 2020/10/24.
//

#import <Foundation/Foundation.h>

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface DDAVPlayer : AVPlayer


+(instancetype)shareInstance ;

- (void)playWithUrlStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
