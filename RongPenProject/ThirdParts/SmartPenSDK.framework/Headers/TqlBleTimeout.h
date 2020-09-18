//
//  TqlBleTimeout.h
//  TQLSmartPen
//
//  Created by tql on 2019/2/18.
//  Copyright © 2019 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/** 超时枚举*/
typedef NS_ENUM(NSUInteger, TQLComandTimeoutType) {
    
    BLE_CONNECT_TIMEOUT = 0x60,
    REQUEST_NAME_TIMEOUT,
    SETUP_NAME_TIMEOUT,/** 1-2 write and get PenName*/
    REQUEST_MAC_TIMEOUT,/** 3 get MAC*/
    REQUEST_FIRWARE_TIMEOUT,/** 4 get firmware Version*/
    REQUEST_BATTARY_TIMEOUT,/** 5  get Battery remianed*/
    REQUEST_RTCTIME_TIMEOUT,
    SETUP_RTCTIME_TIMEOUT,/** 6-7 write and get RTC time*/
    REQUEST_AUTOOFFTIME_TIMEOUT,
    SETUP_AUTOOFFTIME_TIMEOUT,/** 8-9 write and get power off time*/
    SETUP_FACTORYRST_TIMEOUT,/** 10 Factory Reset */
    REQUEST_USEDMEM_TIMEOUT,/** 11 get Memory used */
    REQUEST_AUTOON_TIMEOUT,
    SETUP_AUTOON_TIMEOUT,/** 12-13 write and get Auto power mode*/
    REQUEST_BEEP_TIMEOUT,
    SETUP_BEEP_TIMEOUT,/** 14-15 write and get beep status*/
    REQUEST_SENSITIVITY_TIMEOUT,
    SETUP_SENSITIVITY_TIMEOUT,/** 16-17 write and get Sensitivity level*/
    REQUEST_LEDCOLOR_TIMEOUT,
    SETUP_LEDCOLOR_TIMEOUT,/**  18-19 write and get LED cokor*/
    REQUEST_SENSITIVITYCOLLECTION_TIMEOUT,/** 20 Read Sensitivity Correction*/
    REQUEST_MCU_TIMEOUT, /** 21 get MCUfirmware version*/
    REQUEST_PENMONDEL_TIMEOUT, /** 26 read current Pen Model*/
    REQUEST_CODEPOINTTYPE_TIMEOUT,
    SETUP_CODEPOINTTYPE_TIMEOUT, /** 27-28 write/read current code-point type*/
    REQUEST_LEDCONFIG_TIMEOUT,
    SETUP_LEDCONFIG_TIMEOUT, /** 30-31 write/read LED config open r close*/
    REQUEST_OFFLINEDATAINFO_TIMEOUT, //离线数据/** write and get offline Data*/
    SETUP_OFFLINEDATAUPLOADSTART_TIMEOUT, //开始
    SETUP_OFFLINEDATAUPLOADSTOP_TIMEOUT,//结束
    SETUP_OFFLINEDATAUPLOADPAUSE_TIMEOUT,//暂停
    SETUP_OFFLINEDATAUPLOADCONTINUE_TIMEOUT,//x继续
    REQUEST_DELETEOFFLINEDATA_TIMEOUT,//删除
};
@interface TqlBleTimeout : NSObject
@property (nonatomic, assign) TQLComandTimeoutType requestType; //请求种类，用于区分当前对象是哪个请求。
@property (nonatomic, assign) NSInteger requestTimeout; //当前对象的超时时间，为当前时间+超时时间。
-(instancetype)initWithRequestType:(TQLComandTimeoutType)requestType requestTimeout:(NSInteger)requestTimeout;

@end

NS_ASSUME_NONNULL_END
