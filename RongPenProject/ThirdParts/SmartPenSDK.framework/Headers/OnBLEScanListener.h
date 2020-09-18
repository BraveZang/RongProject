//
//  OnBLEScanListener.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OnBLEScanListener <NSObject>

/** get scan advertisementData*/
- (void)onScanResult:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

@end
