//
//  BLEInterface.h
//  TQLSmartPen
//
//  Created by tql on 2017/10/20.
//  Copyright © 2017年 tqlZj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
/*
 统一对外接口,BLE这个封装的所有功能的对外接口
 */
@interface BLEInterface : NSObject

#pragma mark - 工具类方法
/*
 单例构造方法,共享BLE实例
 */
+ (instancetype)shareBluetooth;
/*
 断开连接
 */
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;

/*
 断开所有连接
 */
- (void)cancelAllPeripheralsConnection;

/**
 停止扫描
 */
- (void)cancelScan;

/**
 //读取Characteristic的详细信息
 */
- (BLEInterface *(^)(CBPeripheral *peripheral,CBCharacteristic *characteristic))characteristicDetails;

/**
 设置characteristic的notify
 */
- (void)notify:(CBPeripheral *)peripheral
characteristic:(CBCharacteristic *)characteristic
         block:(void(^)(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error))block;

/**
 取消characteristic的notify
 */
- (void)cancelNotify:(CBPeripheral *)peripheral
      characteristic:(CBCharacteristic *)characteristic;

/**
 获取当前连接的peripherals
 */
- (NSArray *)findConnectedPeripherals;

/**
 获取当前连接的peripheral
 */
- (CBPeripheral *)findConnectedPeripheral:(NSString *)peripheralName;


- (void)ResetBluetooth;
/**
 获取当前corebluetooth的centralManager对象
 */
- (CBCentralManager *)centralManager;

/**
 添加断开自动重连的外设
 */
- (void)addAutoReconnect:(CBPeripheral *)peripheral;

/**
 删除断开自动重连的外设
 */
- (void)removeAutoReconnect:(CBPeripheral *)peripheral;

/**
 根据外设UUID对应的string获取已配对的外设
 
 通过方法获取外设后可以直接连接外设，跳过扫描过程
 */
- (CBPeripheral *)retrievePeripheralWithUUIDString:(NSString *)UUIDString;

#pragma mark - 链式函数

/**
 查找Peripherals
 */
- (BLEInterface *(^)(void))scanPeripherals;

/**
 连接Peripheral
 */
- (BLEInterface *(^)(void))connectPeripheral;

/**
 发现Services
 */
- (BLEInterface *(^)(void))discoverServices;

/**
 获取Characteristics
 */
- (BLEInterface *(^)(void))discoverCharacteristics;

/**
 更新Characteristics的值
 */
- (BLEInterface *(^)(void))readValueForCharacteristic;

/**
 获取Characteristics的描述
 */
- (BLEInterface *(^)(void))discoverDescriptorsForCharacteristic;

/**
 获取Descriptors的值
 */
- (BLEInterface *(^)(void))readValueForDescriptors;

/**
 开始执行
 */
- (BLEInterface *(^)(void))begin;

/**
 sec秒后停止
 */
- (BLEInterface *(^)(int sec))stop;

/**
 持有对象
 */
- (BLEInterface *(^)(id obj)) having;

/**
 切换委托的频道
 */
- (BLEInterface *(^)(NSString *channel)) channel;

- (BLEInterface *) and;
- (BLEInterface *) then;
- (BLEInterface *) with;
- (BLEInterface *(^)(int))launcher;

#pragma mark - 回调信息处理block

#pragma mark 默认通道

// 6 Manager

- (void)centralManagerDidUpdateStateBlock:(void (^)(CBCentralManager *central))block;//更新蓝牙状态,用于蓝牙状态判断,蓝牙搜索

- (void)centralManagerWillRestoreStateBlock:(void (^)(CBCentralManager *central, NSDictionary *dict))block;//central管理器涉及到要被系统来恢复时调用

- (void)centralManagerDiscoverPeripheralsBlock:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI))block;//查找到外设

- (void)centralManagerConnectPeripheralSuccessBlock:(void (^)(CBCentralManager *central, CBPeripheral *peripheral))block;//连接成功

- (void)centralManagerConnectPeripheralFailBlock:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSError *error))block;//连接失败

- (void)centralManagerDisconnectPeripheralBlock:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSError *error))block;//断开连接

// 13 Peripheral

- (void)peripheralDidUpdateNameBlock:(void (^)(CBPeripheral *peripheral))block;

- (void)peripheralDidModifyServicesBlock:(void (^)(CBPeripheral *peripheral, NSArray<CBService *> * invalidatedServices))block;

//- (void)peripheralDidUpdateRSSIBlock:(void (^)(CBPeripheral *peripheral, NSError *error))block;

- (void)peripheralDidReadRSSIBlock:(void (^)(CBPeripheral *peripheral, NSNumber *RSSI, NSError *error))block;

- (void)peripheralDidDiscoverServicesBlock:(void (^)(CBPeripheral *peripheral, NSError *error))block;

- (void)peripheralDidDiscoverIncludedServicesForServiceBlock:(void (^)(CBPeripheral *peripheral, CBService *service, NSError *error))block;

- (void)peripheralDidDiscoverCharacteristicsForServiceBlock:(void (^)(CBPeripheral *peripheral, CBService *service, NSError *error))block;

- (void)peripheralDidUpdateNotificationStateForCharacteristicBlock:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidUpdateValueForCharacteristicBlock:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidWriteValueForCharacteristicBlock:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidDiscoverDescriptorsForCharacteristicBlock:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidUpdateValueForDescriptorBlock:(void (^)(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error))block;

- (void)peripheralDidWriteValueForDescriptorBlock:(void (^)(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error))block;

#pragma mark 带可选通道

// 6 Manager

- (void)centralManagerDidUpdateStateAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central))block;

- (void)centralManagerWillRestoreStateAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central, NSDictionary *dict))block;

- (void)centralManagerDiscoverPeripheralsAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI))block;

- (void)centralManagerConnectPeripheralSuccessAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central, CBPeripheral *peripheral))block;

- (void)centralManagerConnectPeripheralFailAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSError *error))block;

- (void)centralManagerDisconnectPeripheralAtNotifyChannel:(NSString *)channel block:(void (^)(CBCentralManager *central, CBPeripheral *peripheral, NSError *error))block;

// 13 Peripheral

- (void)peripheralDidUpdateNameAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral))block;

- (void)peripheralDidModifyServicesAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, NSArray<CBService *> * invalidatedServices))block;

//- (void)peripheralDidUpdateRSSIAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, NSError *error))block;

- (void)peripheralDidReadRSSIAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, NSNumber *RSSI, NSError *error))block;

- (void)peripheralDidDiscoverServicesAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, NSError *error))block;

- (void)peripheralDidDiscoverIncludedServicesForServiceAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBService *service, NSError *error))block;

- (void)peripheralDidDiscoverCharacteristicsForServiceAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBService *service, NSError *error))block;

- (void)peripheralDidUpdateNotificationStateForCharacteristicAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidUpdateValueForCharacteristicAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidWriteValueForCharacteristicAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidDiscoverDescriptorsForCharacteristicAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error))block;

- (void)peripheralDidUpdateValueForDescriptorAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error))block;

- (void)peripheralDidWriteValueForDescriptorAtNotifyChannel:(NSString *)channel block:(void (^)(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error))block;

#pragma mark 过滤

- (void)scanForPeripheralsWithOptions:(NSDictionary *)scanForPeripheralsWithOptions
         connectPeripheralWithOptions:(NSDictionary *)connectPeripheralOptions
       scanForPeripheralsWithServices:(NSArray *)scanForPeripheralServiceUUIDsOptions
                 discoverWithServices:(NSArray *)discoverServicesUUIDsOptions
          discoverWithCharacteristics:(NSArray *)discoverCharacteristicUUIDsOptions;


@end
