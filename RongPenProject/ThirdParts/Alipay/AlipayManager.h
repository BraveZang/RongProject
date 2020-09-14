//
//  AlipayManager.h
//  SanMuZhuangXiu
//
//  Created by 王巧云 on 2019/5/27.
//  Copyright © 2019 Darius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

NS_ASSUME_NONNULL_BEGIN
//@protocol AlipayManagerDelegate <NSObject>
//
//@required
//- (void)managerStandbyCallback:(NSDictionary *)resultDic;
//- (void)processAuthStandbyCallback:(NSDictionary *)resultDic;
//@end

@interface AlipayManager : NSObject
//@property (nonatomic, assign) id<AlipayManagerDelegate> delegate;
+ (instancetype)sharedManager;
- (void)processAuthStandbyCallback:(NSDictionary *)resultDic;
- (void)managerStandbyCallback:(NSDictionary *)resultDic;

@end

NS_ASSUME_NONNULL_END
