//
//  AreaModel.h
//  DengHaiSeed
//
//  Created by mac on 31.10.19.
//  Copyright © 2019 ZrteC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreaModel : NSObject
///    省份/城市id
@property (nonatomic, copy) NSString        *ID;
///   父级ID
@property (nonatomic, copy) NSString        *parentId;
///    省份/城市名称
@property (nonatomic, copy) NSString        *name;
/// 子级列表
@property (nonatomic, copy) NSArray         *second;

@end

NS_ASSUME_NONNULL_END
