//
//  PenCommAgent.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TQLPenSignal.h"
#import "BLEInterface.h"
#import "OnBLEScanListener.h"
@protocol  reqPenBatterySuccessDelegate <NSObject>
- (void)reqPenBatterySuccess;
@end

@interface PenCommAgent : NSObject
/** 获取 PenCommAgent 单例*/
+ (instancetype)getInstance;
- (instancetype)init __attribute__((unavailable("Use singleton")));

- (BOOL)isSupportBluetooth;
/** 查找设备*/
- (void)findAllDevices;
/** 停止查找设备*/
- (void)stopFindAllDevices;
/** 连接设备*/
- (void)connect:(CBPeripheral *)peripheral;
/** 断开连接设备*/
- (void)cancelConnect:(CBPeripheral *)peripheral;

//@property (assign, nonatomic) DataType XYDataFormat;//OID4点码不需要使用，仅OID3使用
@property (nonatomic, assign) NSInteger timeoutTime;//超时时间,默认是5s
@property (weak, nonatomic) id<TQLPenSignal> pensignal;
@property (nonatomic, weak) id<reqPenBatterySuccessDelegate>degelate;
@property (weak, nonatomic) id<OnBLEScanListener> onBlEScanListener;
@property (strong, nonatomic) BLEInterface *interface;
@property (nonatomic, assign) BOOL isneedAutoResetTime;//设置成NO不会自动校正
//@property (assign, nonatomic) BOOL isAutoConnect;SDK没有使用
//@property (nonatomic, strong) NSString *dataFilePath;//源数据路径
//@property (nonatomic, assign) BOOL isOfflineDownloading;

/** set start and request All*/
- (void)reqPenStatus;

/** 1-2 write and get PenName*/
- (void)writePenName:(NSString *)penName;
- (void)reqPenName;
- (NSString *)getPenName;

/** 3 get MAC*/
- (void)reqPenMac;
- (NSString *)getPenMac;

/** 4 get firmware Version*/
- (void)reqPenFirmware;
- (NSString *)getPenFirmWare;

/** 5  get Battery remianed*/
- (void)reqPenBattery;
- (int)getBattery;

/** 6-7 write and get RTC time*/
/** system Time */
- (void)writePenTime;//校正RTC时间，写入手机系统时间进行校正
/** every time Time */
//- (void)writePenTime:(long)rtc_time;//不允许写入任意时间，没有意义
- (void)reqPenTime;
- (NSString *)getRTCTime;

/** 8-9 write and get power off time*/
- (void)writePenAutoOffTime:(int)off_time;
- (void)reqPenAutoOffTime;
- (int)getAutoShutDownTime;

/** 10 Factory Reset */
- (void)writePenFactoryRst;

/** 11 get Memory used */
- (void)reqPenUsedMem;
- (int)getUsedmem;

/** 12-13 write and get Auto power mode*/
- (void)writePenAutoOnMode:(BOOL)onoff;
- (void)reqPenAutoOnMode;
- (BOOL)getAutopowermode;

/** 14-15 write and get beep status*/
- (void)writePenBeep:(BOOL)onoff;
- (void)reqPenBeep;
- (BOOL)getBeep;

/** 16-17 write and get Sensitivity level*/
- (void)writePenSensitivity:(int)sensitivity;
- (void)reqPenSensitivity;
- (int)getPenSensitivity;

/**  18-19 write and get LED cokor*/
- (void)writePenLEDColor:(int)color;
- (void)reqPenLEDColor;
- (int)getPenLEDColor;

/** 20 Read Sensitivity Correction*/
- (void)reqSensitivityCorrection;
- (NSString *)getSensitivityCorrection;


/** 21 get MCUfirmware version*/
- (void)reqMcuFirmwareVersion;
- (NSString *)getMcuFirmwareVersion;

/** 22-23 write and get customer id*///暂不开放


/** 24-25 write and get element code*///不需要App设置，由笔自动传出
- (NSString *)getElementCode;

/** 26 read current Pen Model*/
- (void)reqCurrentPenModel;
- (NSString *)getCurrentPenModel;

/** 27-28 write/read current code-point type*///客户不能设置
- (void)reqCurrentCodePointType;
- (NSString *)getCurrentCodePointType;

// 2018.12.15 压缩算法//暂不开放
/** 29 read if it is compress type*/



/** 30-31 write/read LED config open r close*/
- (void)writeLEDConfig:(BOOL)onOff;
- (void)reqLEDConfig;
- (BOOL)getLEDConfig;

///** 32 Set APP Handwriting color*/ //自动回调，不能设置,实时数据变化


/** 33 APP Set OID Value*///调机模式//暂没开放


/** 34 Set BLE Enter OTA Mode*///调机模式,//暂没开放


/** 35 Set BLE Mac Address，暂没开放*/


/** 36 读取OIDValue，工程使用暂没开放*/


/** write and get offline Data*/
- (void)reqOfflineDataInfo;
- (int)getOfflineDataInfo;
- (void)transferOfflineData:(BOOL)isBegain;//开始加载离线数据和停止加载离线数据


//（当前的发布版的蓝牙固件不支持，暂时无法调用）
- (void)pauseOrContinueToTransferOfflineData:(BOOL)isPause;//暂停加载离线数据和继续加载离线数据


- (void)deleteOfflineData;//删除离线数据

//- (void)writePenOffLineConfirm:(BOOL)success;//离线数据加载确认，暂不开放

//保存原始点码数据用于分析飞笔，丢笔等问题，以后会去掉
//- (void)saveDataToWriteDataPath:(NSString *)writeData;已经去掉
//- (void)createManager;已经去掉
//- (void)createfileDataPath;//开启原始数据保存，已经去掉
//-(void)clearDataPath;//清除保存文件，已经去掉

//开始加载文件数据，用于demo过数据使用，以后会去掉
//-(void)getDataFromPath:(NSString *)filePath;已经去掉
//-(void)startSendData;已经去掉
//-(void)stopSendData;已经去掉
@end
