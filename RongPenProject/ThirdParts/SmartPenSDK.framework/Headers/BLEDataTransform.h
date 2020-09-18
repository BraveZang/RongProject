//
//  BLEDataTransform.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLEDataTransform : NSObject

+ (NSString *)bytesToHexString:(Byte[])bytes length:(int)length;
+ (NSString *)ssbytesToHexString:(Byte[])bytes length:(int)length;
+ (NSString *)getNewMacAdress:(NSData *)manufacturerData;
/** get mac address*/
+ (NSString *)getMacAdress:(NSData *)manufacturerData;
+ (BOOL)getIsSmartPen:(NSData *)manufacturerData;
+ (BOOL)getLinkStatus:(NSData *)manufacturerData;


@end
