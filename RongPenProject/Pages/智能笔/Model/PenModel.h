//
//  PenModel.h
//  RongPenProject
//
//  Created by mac on 8.11.20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenModel : NSObject

@property (nonatomic, strong) NSString          *RSSI;
@property (nonatomic, strong) CBPeripheral      *peripheral;

@end

NS_ASSUME_NONNULL_END
