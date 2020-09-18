//
//  TQLPwnSingal.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TqlBleTimeout.h"
@class Dot;

@protocol TQLPenSignal <NSObject>

@optional

#pragma mark --笔状态设置的回调代理

-(void)didUpdatecentralManagerState:(int)state;

/** 连接成功*/
- (void)onConnected:(int)forceMax fwVersion:(NSString *)fwVersion;

/** 连接失败*/
-(void)onConnectFailed;

//写入指令特征更新
-(void)onfinishUpdateCharacteric;
/** 断开连接*/
- (void)onDisconnected;

/** get online Dot*/
- (void)onReceiveDot:(Dot *)dot;

#pragma mark -- 属性
/** 1-2 write and get PenName*/
- (void)onPenNameSetupResponse:(BOOL)isSuccess;
- (void)onRecievePenName:(NSString *)PenName;

/** 3 get MAC*/
- (void)onRecieveMacAdress:(NSString *)MacAdress;

/** 4 get firmware Version*/
-(void)onRecievefirmwareVersion:(NSString *)firmwareVersion;

/** 5  get Battery remianed*/
//- (void)onRecieveaBetteryDat;//加上参数是否正在充电，充电状态为False
- (void)onRecieveaBetteryDat:(int)BetteryDat isCharging:(BOOL)isCharging;

/** 6-7 write and get RTC time*/
/** RCT时间设置*/
- (void)onPenTimetickSetupResponse:(BOOL)isSuccess;
-(void)onRecieveRTCTime:(NSString *)RTCTime;

/** 8-9 write and get power off time*/
- (void)onPenAutoShutdownSetUpResponse:(BOOL) isSuccess;
-(void)onRecievePenAutoOffTime:(int)AutoOffTime;

/** 10 Factory Reset */
- (void)onPenFactoryRstSetUpResponse:(BOOL)isSuccess;

/** 11 get Memory used */
-(void)onRecievePenUsedMem:(int)UsedMem;

/** 12-13 write and get Auto power mode*/
- (void)onPenAutoPowerOnSetUpResponse:(BOOL)isSuccess;
- (void)onRecievePenAutoPowerOn:(BOOL)PowerOn;

/** 14-15 write and get beep status*/
- (void)onPenBeepSetUpResponse:(BOOL)isSuccess;
- (void)onRecievePenBeep:(BOOL)PenBeep;

/** 16-17 write and get Sensitivity level*/
/**压力水平设置*/
- (void)onPenSensitivitySetUpResponse:(BOOL)isSuccess;
- (void)onRecievePenSensitivity:(int)Sensitivity;

/**  18-19 write and get LED cokor*/
- (void)onPenLEDColorSetUpResponse:(BOOL)isSuccess;
- (void)onRecievePenLEDColor:(int)LEDColor;

/** 20 Read Sensitivity Correction*/
- (void)onRecievePenSensitivityCorrectionTwentyMin:(NSString *)minCorrection threeHMax:(NSString *)maxSensitivity;

/** 21 get MCU firmware version*/
- (void)onRecievePenMcuFirmwareVersion:(NSString *)McuFirmwareVersion;

/** 22-23 write and get customer id*/
//- (void)onCustomerIDSetupResponse:(BOOL)isSuccess;不使用已去掉
//- (void)onRecievePenCustomerID:(NSString *)CustomerID;不使用已去掉

/** 24-25 write and get element code*/
//- (void)onElementCodeSetUpResponse:(BOOL)isSuccess;不使用已去掉
- (void)onRecievePenElementCode:(NSString *)ElementCode;

/** 26 read current Pen Model*/
-(void)onRecieveCurrentPenModel:(NSString *)PenModel;

/** 27-28 write/read current code-point type*/
//- (void)onCurrentCodePointTypeSetupResponse:(BOOL)isSuccess;不使用已去掉
-(void)onRecieveCurrentCodePointType:(NSString *)codePoint;

/** 29 read if it is compress type*/
//-(void)onRecieveIfIsCompressType:(BOOL)CompressType;不使用已去掉

/** 30-31 write/read LED config open r close*/
- (void)onLEDConfigSetupResponse:(BOOL)isSuccess;
-(void)onRecieveLEDConfig:(BOOL)LEDConfig;

/** 32 Set APP Handwriting color*/
- (void)onHandwritingColorSetupResponse:(int)color;

/** 33 APP Set OID Value*/
//- (void)onOIDValueSetupResponse:(BOOL)isSuccess;不使用已去掉

/** 34 Set BLE Enter OTA Mode*/
//- (void)onEnterOTAModeSetupResponse:(BOOL)isSuccess;不使用已去掉

/** 35 Set MacAddress*/
//- (void)onMacAddressSetupResponse:(BOOL)isSuccess;不使用已去掉
/** 36 ReadOIDValue*/

//- (void)onRecieveOIDValue:(NSString *)OIDValue;不使用已去掉

#pragma -- mark offlineData
- (void)onOfflineDataList:(int)offlineNotes;
/** 开始加载离线数据*/
- (void)onStartOfflineDownload:(BOOL)isSuccess;
/** 停止加载离线数据*/
- (void)onStopOfflineDownload:(BOOL)isSuccess;

//（当前的发布版的蓝牙固件不支持暂停和继续，暂时无法调用）
/** 暂停加载离线数据*/
- (void)onPauseOfflineDownload:(BOOL)isSuccess;
/** 继续加载离线数据*/
- (void)onContinueOfflineDownload:(BOOL)isSuccess;


/** 加载离线数据完成*/
- (void)onFinishedOfflineDownload:(BOOL)isSuccess;
/** 离线数据的进度条*/
-(void)offlineStrokesProgress:(int)progress;
/** 删除离线数据*/
-(void)onDeleteOfflineData:(BOOL)isSuccess;
/** 接收离线数据*/
- (void)onReceiveOfflineStrokes:(Dot *)dot;

/** get dot config data*/
- (void)onReceivePenStatus:(NSString *)timetick
                   PenName:(NSString *)penName
                   MacAdress:(NSString *)macAdress
                  forcemax:(int)forcemax
                   battery:(int)battery
                   usedmem:(int)usedmem
             autopowerMode:(BOOL)autopowerMode
                      beep:(BOOL)beep
          autoshutdownTime:(short)autoshutdownTime
            penSensitivity:(short)penSensitivity
                  penColor:(int)penColor
               ComstomerID:(NSString *)ComstomerID
                  PenModel:(NSString *)penModel
              offlineDataList:(int)dataList;


#pragma mark -- other
//revieveArchiveElementCode、PenNote封存笔迹使用不使用已去掉
//-(void)onRecieveArchiveElementCode:(NSString *)str;

//离线数据颜色改变
-(void)offlineDataColorChange:(UIColor *)offlineDataColor;

//超时回调
-(void)requestOrTComandTimeout:(TQLComandTimeoutType)timeoutType;

@end

